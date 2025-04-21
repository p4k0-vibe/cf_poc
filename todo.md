# Tareas Pendientes - Proyecto de Gestión de Gastos Familiares

## Configuración Inicial

- [x] Crear cuenta en Cloudflare
- [x] Crear proyecto en Firebase para autenticación
- [ ] Instalar dependencias del frontend: `cd frontend && npm install`
- [ ] Instalar dependencias del backend: `cd backend && pip install -r requirements.txt`
- [ ] Instalar Wrangler CLI: `npm install -g wrangler`
- [x] Instalar Terraform CLI

## Frontend

- [ ] Configurar archivo `.env` con las credenciales de Firebase
- [ ] Implementar componente para agregar nuevos gastos
- [ ] Implementar vista de detalle de gastos
- [ ] Implementar filtrado y búsqueda de gastos
- [ ] Implementar funcionalidad para subir comprobantes
- [ ] Añadir validación de formularios
- [ ] Completar página de perfil de usuario
- [ ] Implementar visualización de gráficos de gastos
- [ ] Implementar funcionalidad para compartir gastos entre usuarios
- [ ] Realizar pruebas de UI/UX

## Backend

- [ ] Inicializar base de datos D1 en Cloudflare
- [ ] Crear bucket R2 para almacenamiento de comprobantes
- [ ] Implementar endpoints para CRUD completo de gastos
- [ ] Implementar endpoints para gestión de categorías
- [ ] Implementar endpoints para gestión de métodos de pago
- [ ] Implementar endpoints para gestión de grupos familiares
- [ ] Implementar lógica para subida y descarga de comprobantes
- [ ] Implementar validación de datos y manejo de errores
- [ ] Configurar correctamente la autenticación con Firebase
- [ ] Realizar pruebas de API

## Infraestructura

- [x] Crear configuración de Terraform para Cloudflare
- [x] Crear configuración de Terraform para GCP/Firebase
- [x] Configurar módulos de Terraform para mejor organización
- [x] Implementar git hooks para validar la configuración de Terraform
- [ ] Configurar backend para Terraform (para almacenar el estado)
- [ ] Completar archivo `terraform.tfvars` con credenciales de Cloudflare
- [ ] Completar archivo `terraform.tfvars` con credenciales de GCP/Firebase
- [x] Validar configuración de Terraform: `terraform init && terraform validate`
- [ ] Aplicar configuración de Terraform: `terraform init && terraform apply`
- [ ] Verificar la correcta creación de recursos en Cloudflare
- [ ] Verificar la correcta creación de recursos en GCP/Firebase
- [ ] Configurar dominio personalizado (opcional)
- [ ] Establecer políticas de seguridad para Workers y R2

## CI/CD

- [x] Crear workflow para despliegue de infraestructura de Cloudflare
- [x] Crear workflow para despliegue de infraestructura de GCP/Firebase
- [ ] Configurar secretos en GitHub Actions para Cloudflare
- [ ] Configurar secretos en GitHub Actions para GCP/Firebase
- [ ] Verificar pipeline de despliegue de infraestructura de Cloudflare
- [ ] Verificar pipeline de despliegue de infraestructura de GCP/Firebase
- [ ] Verificar pipeline de despliegue del frontend
- [ ] Verificar pipeline de despliegue del backend
- [ ] Configurar notificaciones de despliegue
- [ ] Implementar tests automatizados

## Documentación

- [x] Documentar configuración de infraestructura
- [x] Documentar secretos necesarios para CI/CD
- [x] Estructurar módulos y crear READMEs para cada componente
- [ ] Documentar API con Swagger o similar
- [ ] Crear guía de usuario
- [x] Actualizar README con instrucciones detalladas de instalación y uso
- [ ] Documentar estructura de la base de datos 