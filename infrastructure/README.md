# Infraestructura como Código (IaC)

Este directorio contiene la configuración de Terraform para los recursos en Cloudflare y GCP/Firebase.

## Estructura de archivos

- `main.tf` - Recursos de Cloudflare
- `gcp.tf` - Recursos de GCP/Firebase
- `providers.tf` - Configuración de proveedores
- `variables.tf` - Definición de variables
- `outputs.tf` - Outputs de Terraform
- `terraform.tfvars.example` - Ejemplo de archivo de variables (no subir el real al repositorio)

## Despliegue manual

1. Copia `terraform.tfvars.example` a `terraform.tfvars`
2. Completa los valores en `terraform.tfvars` con tus credenciales
3. Inicializa Terraform:
   ```
   terraform init
   ```
4. Planifica los cambios:
   ```
   terraform plan
   ```
5. Aplica los cambios:
   ```
   terraform apply
   ```

## Despliegue automatizado (GitHub Actions)

El repositorio incluye dos workflows de GitHub Actions para el despliegue automático:

- `terraform-cloudflare.yml` - Despliega recursos en Cloudflare
- `terraform-gcp.yml` - Despliega recursos en GCP/Firebase

### Secretos requeridos en GitHub

Para que los workflows funcionen correctamente, debes configurar los siguientes secretos en la configuración de GitHub:

#### Secretos para Cloudflare

- `CLOUDFLARE_API_TOKEN` - Token de API de Cloudflare
- `CLOUDFLARE_ACCOUNT_ID` - ID de cuenta de Cloudflare
- `CLOUDFLARE_ZONE_ID` - ID de zona de Cloudflare (si usas un dominio personalizado)
- `CUSTOM_DOMAIN` - Dominio personalizado (opcional)
- `ALLOWED_ORIGINS` - Lista de orígenes permitidos para CORS (separados por comas)

#### Secretos para GCP/Firebase

- `GCP_PROJECT_ID` - ID del proyecto de GCP
- `GCP_SA_KEY` - Clave de cuenta de servicio de GCP en formato JSON
- `GCP_REGION` - Región de GCP (por defecto: us-central1)
- `FIREBASE_PROJECT_ID` - ID del proyecto de Firebase (generalmente igual que `GCP_PROJECT_ID`)
- `FIRESTORE_LOCATION` - Ubicación para Firestore (por defecto: us-central)
- `ALLOWED_ORIGINS_LIST` - Lista de orígenes permitidos para CORS (un origen por secreto)

#### Secretos para Terraform State

- `TERRAFORM_STATE_BUCKET` - Nombre del bucket para el estado de Terraform

### Cómo crear una cuenta de servicio de GCP

1. Ve a la [Consola de Google Cloud](https://console.cloud.google.com/)
2. Navega a "IAM & Admin" > "Service Accounts"
3. Haz clic en "Create Service Account"
4. Asigna un nombre y descripción
5. Agrega los siguientes roles:
   - Firebase Admin
   - Cloud Datastore Owner
   - Storage Admin
   - Service Usage Admin
6. Crea una clave JSON y descárgala
7. Agrega el contenido del archivo JSON como secreto `GCP_SA_KEY` en GitHub

## Outputs

Después del despliegue, los outputs importantes se capturan y están disponibles como artefactos en GitHub Actions:

- `terraform-cloudflare-output.txt` - IDs y URLs de recursos de Cloudflare
- `terraform-gcp-output.txt` - IDs y URLs de recursos de GCP/Firebase

Estos outputs incluyen información necesaria para configurar el frontend y backend. 