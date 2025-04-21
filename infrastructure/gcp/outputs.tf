output "firebase_web_app_config" {
  description = "Firebase Web App config"
  value       = google_firebase_web_app.gastos_app.app_id
  sensitive   = false
}

output "storage_bucket_url" {
  description = "URL of the GCP Storage bucket for receipts"
  value       = "gs://${google_storage_bucket.receipts_bucket.name}"
}

output "firebase_hosting_url" {
  description = "URL for the Firebase hosting"
  value       = "https://${var.gcp_project_id}.web.app"
}

output "firestore_database" {
  description = "Firestore database name"
  value       = google_firestore_database.database.name
} 
