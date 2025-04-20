terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_d1_database" "expenses_db" {
  name       = "gastos_familiares_db"
  account_id = var.cloudflare_account_id
}

resource "cloudflare_r2_bucket" "receipts_bucket" {
  account_id = var.cloudflare_account_id
  name       = "receipts-bucket"
  location   = "wnam"
}

resource "cloudflare_workers_kv_namespace" "session_kv" {
  account_id = var.cloudflare_account_id
  title      = "gastos_familiares_sessions"
}

resource "cloudflare_worker_script" "api_worker" {
  account_id = var.cloudflare_account_id
  name       = "gastos-familiares-api"
  content    = file("${path.module}/../backend/src/main.py")

  d1_database_bindings {
    name        = "DB"
    database_id = cloudflare_d1_database.expenses_db.id
  }

  r2_bucket_binding {
    name        = "RECEIPTS_BUCKET"
    bucket_name = cloudflare_r2_bucket.receipts_bucket.name
  }

  kv_namespace_binding {
    name         = "KV"
    namespace_id = cloudflare_workers_kv_namespace.session_kv.id
  }

  # Environment variables
  vars = {
    FIREBASE_PROJECT_ID = var.firebase_project_id
    ALLOWED_ORIGINS     = var.allowed_origins
  }

  # Security settings
  security_headers {
    enabled = true
  }

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
