// Habilitar las API necesarias
resource "google_project_service" "firebase" {
  project            = var.gcp_project_id
  service            = "firebase.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "firestore" {
  project            = var.gcp_project_id
  service            = "firestore.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "storage" {
  project            = var.gcp_project_id
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}

// Firebase: Configuración de Authentication
resource "google_firebase_web_app" "gastos_app" {
  provider     = google-beta
  project      = var.gcp_project_id
  display_name = "Gastos Familiares App"
  depends_on   = [google_project_service.firebase]
}

// Bucket para almacenar los archivos de configuración de la app web
resource "google_storage_bucket" "firebase_hosting" {
  name     = "${var.gcp_project_id}-firebase-hosting"
  location = var.gcp_region
  project  = var.gcp_project_id

  uniform_bucket_level_access = true

  depends_on = [google_project_service.storage]
}

// Configuración de Firestore (modo nativo)
resource "google_app_engine_application" "firebase_app" {
  provider      = google-beta
  project       = var.gcp_project_id
  location_id   = var.firestore_location
  database_type = "CLOUD_FIRESTORE"
}

resource "google_firestore_database" "database" {
  project     = var.gcp_project_id
  name        = "(default)"
  location_id = var.firestore_location
  type        = "FIRESTORE_NATIVE"

  depends_on = [google_app_engine_application.firebase_app]
}

// Reglas de Firestore
resource "google_firestore_document" "firestore_rules" {
  provider    = google-beta
  project     = var.gcp_project_id
  collection  = "_firestore_rules"
  document_id = "cloud_firestore_rules"
  fields      = <<EOT
{
  "rules": {
    "stringValue": "rules_version = '2';\nservice cloud.firestore {\n  match /databases/{database}/documents {\n    match /users/{userId} {\n      allow read, write: if request.auth != null && request.auth.uid == userId;\n    }\n    match /expenses/{expenseId} {\n      allow read, write: if request.auth != null && resource.data.userId == request.auth.uid;\n    }\n    match /categories/{categoryId} {\n      allow read: if request.auth != null;\n      allow write: if request.auth != null && request.resource.data.createdBy == request.auth.uid;\n    }\n    match /paymentMethods/{methodId} {\n      allow read: if request.auth != null;\n      allow write: if request.auth != null && request.resource.data.createdBy == request.auth.uid;\n    }\n    match /groups/{groupId} {\n      allow read: if request.auth != null && exists(/databases/$(database)/documents/group_members/$(groupId)_$(request.auth.uid));\n      allow write: if request.auth != null && request.resource.data.createdBy == request.auth.uid;\n    }\n    match /group_members/{memberId} {\n      allow read: if request.auth != null && resource.data.userId == request.auth.uid;\n      allow write: if request.auth != null && request.resource.data.userId == request.auth.uid;\n    }\n  }\n}\n"
  }
}
EOT

  depends_on = [google_firestore_database.database]
}

// Bucket de Storage para almacenar comprobantes
resource "google_storage_bucket" "receipts_bucket" {
  name     = "${var.gcp_project_id}-receipts-bucket"
  location = var.gcp_region
  project  = var.gcp_project_id

  uniform_bucket_level_access = true

  # Configuración CORS para el bucket
  cors {
    origin          = var.allowed_origins_list
    method          = ["GET", "POST", "PUT", "DELETE", "HEAD"]
    response_header = ["Content-Type", "Access-Control-Allow-Origin"]
    max_age_seconds = 3600
  }

  depends_on = [google_project_service.storage]
}

// IAM para el bucket de comprobantes
resource "google_storage_bucket_iam_binding" "public_read" {
  bucket = google_storage_bucket.receipts_bucket.name
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_iam_binding" "authenticated_write" {
  bucket = google_storage_bucket.receipts_bucket.name
  role   = "roles/storage.objectCreator"
  members = [
    "allAuthenticatedUsers",
  ]
}

resource "google_firebase_web_app" "basic" {
  provider     = google-beta
  project      = var.gcp_project_id
  display_name = "Gastos Familiares"
}

# Usar data source en lugar de resource para la configuración de la aplicación web
data "google_firebase_web_app_config" "basic" {
  provider   = google-beta
  web_app_id = google_firebase_web_app.basic.app_id
  depends_on = [google_firebase_web_app.basic]
}

resource "google_storage_bucket" "default" {
  name                        = "${var.gcp_project_id}.appspot.com"
  project                     = var.gcp_project_id
  location                    = var.gcp_region
  uniform_bucket_level_access = true
  force_destroy               = true

  # Configuración CORS para el bucket
  cors {
    origin          = var.allowed_origins_list
    method          = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    response_header = ["Content-Type", "Access-Control-Allow-Origin"]
    max_age_seconds = 3600
  }
}

# Enable Cloud Functions API
resource "google_project_service" "cloudfunctions" {
  project = var.gcp_project_id
  service = "cloudfunctions.googleapis.com"

  disable_on_destroy = false
}

# Enable Cloud Build API
resource "google_project_service" "cloudbuild" {
  project = var.gcp_project_id
  service = "cloudbuild.googleapis.com"

  disable_on_destroy = false
}

# Enable Artifact Registry API
resource "google_project_service" "artifactregistry" {
  project = var.gcp_project_id
  service = "artifactregistry.googleapis.com"

  disable_on_destroy = false
}

# Enable Cloud Run API
resource "google_project_service" "cloudrun" {
  project = var.gcp_project_id
  service = "run.googleapis.com"

  disable_on_destroy = false
}

# Create a Cloud Storage bucket for Cloud Functions source code
resource "google_storage_bucket" "function_bucket" {
  name                        = "${var.gcp_project_id}-functions"
  location                    = var.gcp_region
  uniform_bucket_level_access = true

  # Configuración CORS para el bucket
  cors {
    origin          = var.allowed_origins_list
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}
