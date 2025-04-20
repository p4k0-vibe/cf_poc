# Cloudflare Workers y Pages POC

Esta prueba de concepto (POC) demuestra la integración de un backend construido con Cloudflare Workers y un frontend desplegado en Cloudflare Pages.

## Estructura del Proyecto

```
cf_poc/
├── backend/           # API con Cloudflare Workers
│   ├── src/
│   ├── wrangler.toml
│   └── package.json
├── frontend/          # Aplicación web con Cloudflare Pages
│   ├── public/
│   ├── src/
│   └── package.json
└── README.md
```

## Backend (Cloudflare Workers)

El backend utiliza Cloudflare Workers para crear una API serverless con las siguientes características:

- Endpoints RESTful
- Almacenamiento con Cloudflare KV o D1
- Autenticación JWT
- CORS configurado para el frontend

## Frontend (Cloudflare Pages)

El frontend es una aplicación web moderna desplegada en Cloudflare Pages:

- Framework a elección (React, Vue, Svelte, etc.)
- Comunicación con la API del backend
- Diseño responsive
- Experiencia de usuario optimizada

## Configuración y Despliegue

### Requisitos previos
- Cuenta en Cloudflare
- Node.js
- Wrangler CLI (`npm install -g wrangler`)

### Pasos para el desarrollo
1. Clonar este repositorio
2. Configurar el backend y frontend según las instrucciones en sus respectivos directorios
3. Desarrollar y probar localmente
4. Desplegar a Cloudflare

## Ventajas de esta arquitectura

- Despliegue automatizado
- Escalabilidad automática
- Baja latencia global (red de Cloudflare)
- Costo optimizado (modelo serverless)
- Integración CI/CD con GitHub