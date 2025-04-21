// Modulos para los diferentes servicios
module "cloudflare" {
  source = "./cloudflare"

  // Variables para Cloudflare
  cloudflare_api_token  = var.cloudflare_api_token
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_zone_id    = var.cloudflare_zone_id
  custom_domain         = var.custom_domain
  firebase_project_id   = var.firebase_project_id
  allowed_origins       = var.allowed_origins
}

module "gcp" {
  source = "./gcp"

  // Variables para GCP/Firebase
  gcp_project_id        = var.gcp_project_id
  gcp_region            = var.gcp_region
  gcp_credentials       = var.gcp_credentials_file
  firestore_location    = var.firestore_location
  allowed_origins_list  = var.allowed_origins_list
  cloudflare_api_token  = var.cloudflare_api_token
  cloudflare_account_id = var.cloudflare_account_id
}
