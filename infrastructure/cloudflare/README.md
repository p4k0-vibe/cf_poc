# Módulo de Cloudflare

Este módulo gestiona los recursos de Cloudflare necesarios para la aplicación de Gastos Familiares.

## Recursos creados

* Base de datos D1 (gastos_familiares_db)
* Bucket R2 para comprobantes (receipts-bucket)
* Namespace KV para sesiones (gastos_familiares_sessions)
* Worker Script para la API
* Proyecto de Pages para el frontend
* Registros DNS y rutas de Worker (opcional si se usa dominio personalizado)

## Variables requeridas

* `cloudflare_api_token`: Token de API de Cloudflare
* `cloudflare_account_id`: ID de la cuenta de Cloudflare
* `cloudflare_zone_id`: ID de la zona de Cloudflare (si se usa dominio personalizado)
* `custom_domain`: Dominio personalizado (opcional)
* `firebase_project_id`: ID del proyecto de Firebase
* `allowed_origins`: Lista de orígenes permitidos para CORS (separados por comas)

## Outputs

* `d1_database_id`: ID de la base de datos D1 creada
* `r2_bucket_name`: Nombre del bucket R2 creado
* `worker_route`: Ruta del Worker para la API
* `pages_url`: URL del despliegue de Pages
* `wrangler_config_update`: Comando para actualizar wrangler.toml con el ID de la base de datos D1 