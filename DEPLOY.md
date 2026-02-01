# HQ Control Center

Sistema de gestión centralizado con Supabase backend.

## 🌐 Deploy en Vercel

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/difortunastudio/HQ-ControlCenter)

## 🚀 Deployment Rápido

### Opción 1: Deploy automático desde GitHub

1. Ve a [vercel.com](https://vercel.com)
2. Conecta tu GitHub
3. Importa el repo: `difortunastudio/HQ-ControlCenter`
4. Click "Deploy"

### Opción 2: Deploy desde CLI

```bash
npm i -g vercel
vercel
```

## 🔧 Configuración de Supabase

Después del deploy, agrega las variables de entorno en Vercel:

```bash
NEXT_PUBLIC_SUPABASE_URL=tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu-anon-key
```

**Configurar en Vercel:**
1. Ve a tu proyecto en Vercel
2. Settings → Environment Variables
3. Agrega las variables de Supabase
4. Redeploy

## 📱 Acceso

Una vez deployed, tendrás URLs como:
- **Production:** `https://hq-control-center.vercel.app`
- **Custom Domain:** `https://hq.tudominio.com` (opcional)

## 🎯 Características

- ✅ Deploy automático en cada push
- ✅ HTTPS por defecto
- ✅ CDN global
- ✅ Acceso desde cualquier dispositivo
- ✅ Integración perfecta con Supabase
- ✅ Zero config

## 📂 Estructura

```
/
├── index.html              # Redirect a /files/index.html
├── files/
│   └── index.html         # Control Center principal
└── vercel.json            # Configuración de Vercel
```

## 🔄 Actualizar

Simplemente haz push a main:

```bash
git add .
git commit -m "Update"
git push
```

Vercel desplegará automáticamente.

---

**Stack:** HTML + Supabase + Vercel  
**Última actualización:** Febrero 2026
