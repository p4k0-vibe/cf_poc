output "cloudflare_d1_database_id" {
  description = "ID of the created D1 database"
  value       = module.cloudflare.d1_database_id
}

output "cloudflare_r2_bucket_name" {
  description = "Name of the created R2 bucket"
  value       = module.cloudflare.r2_bucket_name
}

output "cloudflare_worker_route" {
  description = "Worker route for the API"
  value       = module.cloudflare.worker_route
}

output "cloudflare_pages_url" {
  description = "URL for the Pages deployment"
  value       = module.cloudflare.pages_url
}

output "wrangler_config_update" {
  description = "Command to update wrangler.toml with the D1 database ID"
  value       = module.cloudflare.wrangler_config_update
}

# GCP/Firebase outputs
output "firebase_web_app_config" {
  description = "Firebase Web App config"
  value       = module.gcp.firebase_web_app_config
  sensitive   = false
}

output "gcp_storage_bucket_url" {
  description = "URL of the GCP Storage bucket for receipts"
  value       = module.gcp.storage_bucket_url
}

output "firebase_hosting_url" {
  description = "URL for the Firebase hosting"
  value       = module.gcp.firebase_hosting_url
}

output "firestore_database" {
  description = "Firestore database name"
  value       = module.gcp.firestore_database
}
