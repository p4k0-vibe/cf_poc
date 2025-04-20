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
├── infrastructure/    # Configuración de Terraform para Cloudflare
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── .github/           # GitHub Actions para CI/CD
│   └── workflows/
│       ├── frontend.yml
│       └── backend.yml
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
- Cloudflare como proveedor cloud

## Configuración y Despliegue

### Requisitos previos
- Cuenta en Cloudflare
- Cuenta en Firebase
- Node.js y npm
- Python 3.9+
- Terraform CLI
- Wrangler CLI

### Desarrollo Local
1. Clonar este repositorio
2. Configurar las variables de entorno según `.env.example`
3. Seguir las instrucciones en las carpetas `frontend` y `backend`

## Flujo de Trabajo

El sistema utiliza GitHub Actions para CI/CD:
- Al hacer push a la rama `main` en la carpeta `frontend`, se despliega automáticamente a Cloudflare Pages
- Al hacer push a la rama `main` en la carpeta `backend`, se despliega automáticamente a Cloudflare Workers