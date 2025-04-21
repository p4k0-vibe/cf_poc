variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "gcp_credentials" {
  description = "GCP Service Account key file"
  type        = string
  sensitive   = true
}

variable "firestore_location" {
  description = "Firestore location"
  type        = string
  default     = "us-central"
}

variable "allowed_origins_list" {
  description = "List of allowed origins for CORS"
  type        = list(string)
  default     = ["*"]
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}
