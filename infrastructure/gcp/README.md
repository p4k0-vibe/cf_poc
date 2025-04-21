# Módulo de GCP/Firebase

Este módulo gestiona los recursos de Google Cloud Platform y Firebase necesarios para la aplicación de Gastos Familiares.

## Recursos creados

* Habilitación de APIs necesarias (Firebase, Firestore, Storage, etc.)
* Configuración de Firebase Authentication
* Base de datos Firestore (modo nativo)
* Buckets de Storage para comprobantes y hosting
* Reglas de Firestore
* Configuración de CORS para Storage
* Configuración de IAM para los buckets

## Variables requeridas

* `gcp_project_id`: ID del proyecto de GCP
* `gcp_region`: Región de GCP (por defecto: us-central1)
* `gcp_credentials`: Contenido del archivo de credenciales de GCP (JSON)
* `firestore_location`: Ubicación para Firestore (por defecto: us-central)
* `allowed_origins_list`: Lista de orígenes permitidos para CORS
* `cloudflare_api_token`: Token de API de Cloudflare (para integración)
* `cloudflare_account_id`: ID de la cuenta de Cloudflare (para integración)

## Outputs

* `firebase_web_app_config`: Configuración de la app web de Firebase
* `storage_bucket_url`: URL del bucket de Storage para comprobantes
* `firebase_hosting_url`: URL para el hosting de Firebase
* `firestore_database`: Nombre de la base de datos Firestore 