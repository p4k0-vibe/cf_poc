output "d1_database_id" {
  description = "ID of the created D1 database"
  value       = cloudflare_d1_database.expenses_db.id
}

output "r2_bucket_name" {
  description = "Name of the created R2 bucket"
  value       = cloudflare_r2_bucket.receipts_bucket.name
}

output "worker_route" {
  description = "Worker route for the API"
  value       = var.custom_domain != "" ? "https://api.${var.custom_domain}" : "https://${cloudflare_worker_script.api_worker.name}.${var.cloudflare_account_id}.workers.dev"
}

output "pages_url" {
  description = "URL for the Pages deployment"
  value       = "https://${cloudflare_pages_project.frontend.name}.pages.dev"
}

output "wrangler_config_update" {
  description = "Command to update wrangler.toml with the D1 database ID"
  value       = "Update wrangler.toml: database_id = \"${cloudflare_d1_database.expenses_db.id}\""
}
