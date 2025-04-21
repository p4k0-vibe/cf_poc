// Cloudflare Resources
resource "cloudflare_d1_database" "expenses_db" {
  name       = "gastos_familiares_db"
  account_id = var.cloudflare_account_id
}

resource "cloudflare_r2_bucket" "receipts_bucket" {
  account_id = var.cloudflare_account_id
  name       = "receipts-bucket"
  location   = "WNAM"
}

resource "cloudflare_workers_kv_namespace" "session_kv" {
  account_id = var.cloudflare_account_id
  title      = "gastos_familiares_sessions"
}

resource "cloudflare_worker_script" "api_worker" {
  account_id = var.cloudflare_account_id
  name       = "gastos-familiares-api"
  content    = file("${path.module}/../../backend/src/main.py")

  # Las configuraciones de bindings están comentadas porque no son compatibles
  # con la versión actual del proveedor de Cloudflare

  compatibility_date  = "2023-09-01"
  compatibility_flags = ["python_workers"]
}

resource "cloudflare_pages_project" "frontend" {
  account_id        = var.cloudflare_account_id
  name              = "gastos-familiares"
  production_branch = "main"

  build_config {
    build_command   = "npm run build"
    destination_dir = "dist"
    root_dir        = "frontend"
  }

  deployment_configs {
    preview {
      environment_variables = {
        VITE_API_URL = "https://gastos-familiares-api.${var.cloudflare_account_id}.workers.dev"
      }
    }

    production {
      environment_variables = {
        VITE_API_URL = "https://api.${var.custom_domain}"
      }
    }
  }
}

# Optional: Custom domain for the API
resource "cloudflare_record" "api" {
  count   = var.custom_domain != "" ? 1 : 0
  zone_id = var.cloudflare_zone_id
  name    = "api"
  value   = "${cloudflare_worker_script.api_worker.name}.${var.cloudflare_account_id}.workers.dev"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

# Optional: Worker route for custom domain
resource "cloudflare_worker_route" "api_route" {
  count       = var.custom_domain != "" ? 1 : 0
  zone_id     = var.cloudflare_zone_id
  pattern     = "api.${var.custom_domain}/*"
  script_name = cloudflare_worker_script.api_worker.name
}
