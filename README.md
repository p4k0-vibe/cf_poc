# Gestión de Gastos Familiares

Aplicación para administrar gastos mensuales familiares con múltiples usuarios, formas de pago y categorización de gastos.

## Características Principales

- **Múltiples usuarios** para gestión familiar colaborativa
- **Diferentes métodos de pago** (efectivo, tarjetas, transferencias, etc.)
- **Categorización de gastos** (alimentos, servicios, transporte, etc.)
- **Reportes y análisis** de gastos mensuales
- **Almacenamiento de comprobantes** de pagos
- **Autenticación segura** con Firebase Auth

## Arquitectura Técnica

```
cf_poc/
├── frontend/          # Aplicación React con TypeScript y Tailwind CSS
│   ├── public/
│   ├── src/
│   └── package.json
├── backend/           # API Python con Cloudflare Workers
│   ├── src/
│   ├── wrangler.toml
│   └── requirements.txt
├── infrastructure/    # Configuración de Terraform para Cloudflare y GCP/Firebase
│   ├── cloudflare/    # Módulo de Cloudflare
│   ├── gcp/           # Módulo de GCP/Firebase
│   ├── main.tf        # Configuración de módulos
│   ├── providers.tf
│   ├── variables.tf
│   └── outputs.tf
├── git-hooks/         # Hooks para control de calidad de código
│   ├── pre-commit     # Verifica la configuración de Terraform
│   └── install-hooks.sh
├── .github/           # GitHub Actions para CI/CD
│   └── workflows/
│       ├── frontend.yml
│       ├── backend.yml
│       ├── terraform-cloudflare.yml
│       └── terraform-gcp.yml
└── README.md
```

## Stack Tecnológico

### Frontend
- React con TypeScript
- Tailwind CSS para estilos
- Firebase Auth para autenticación
- CI/CD con GitHub Actions

### Backend
- Python en Cloudflare Workers
- Cloudflare D1 (base de datos SQL)
- Cloudflare R2 para almacenamiento de archivos (comprobantes)

### Infraestructura
- Terraform para infraestructura como código
- Cloudflare como proveedor cloud principal
- GCP/Firebase para autenticación y almacenamiento de datos

## Configuración y Despliegue

### Requisitos previos
- Cuenta en Cloudflare
- Cuenta en Firebase/GCP
- Node.js y npm
- Python 3.9+
- Terraform CLI
- Wrangler CLI

### Configuración de la infraestructura
1. Consulta las instrucciones detalladas en [infrastructure/README.md](infrastructure/README.md)
2. Configura los secretos en GitHub según las instrucciones
3. Ejecuta los workflows de Terraform para crear la infraestructura, o hazlo manualmente

### Desarrollo Local
1. Clona este repositorio
2. Configura las variables de entorno según `.env.example`
3. Instala las dependencias del frontend: `cd frontend && npm install`
4. Instala las dependencias del backend: `cd backend && pip install -r requirements.txt`
5. Ejecuta el frontend: `cd frontend && npm run dev`
6. Ejecuta el backend localmente con Wrangler: `cd backend && wrangler dev`

### Git Hooks

Este proyecto incluye git hooks para asegurar la calidad del código antes de cada commit:

1. **Pre-commit**: Ejecuta `terraform validate` para verificar la configuración de Terraform

Para instalar los git hooks, ejecuta:

```bash
./git-hooks/install-hooks.sh
```

Esto copiará los hooks al directorio `.git/hooks` y los hará ejecutables.

## Flujo de Trabajo de CI/CD

El sistema utiliza GitHub Actions para CI/CD:

- **Infraestructura**: 
  - Al hacer push a la rama `main` con cambios en los archivos de infraestructura, se despliegan automáticamente los recursos en Cloudflare y GCP/Firebase.
  
- **Aplicación**:
  - Al hacer push a la rama `main` en la carpeta `frontend`, se despliega automáticamente a Cloudflare Pages
  - Al hacer push a la rama `main` en la carpeta `backend`, se despliega automáticamente a Cloudflare Workers

## Lista de Tareas Pendientes

Consulta [todo.md](todo.md) para un listado completo de tareas pendientes.