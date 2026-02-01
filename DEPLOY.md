# HQ Control Center

Sistema de gestión centralizado con Supabase backend.

## 🌐 Deploy en Netlify

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/difortunastudio/HQ-ControlCenter)

## 🚀 Deployment Rápido

### Opción 1: Deploy automático desde GitHub

1. Ve a [app.netlify.com](https://app.netlify.com)
2. Click en "Add new site" → "Import an existing project"
3. Conecta tu GitHub
4. Selecciona: `difortunastudio/HQ-ControlCenter`
5. Configuración:
   - Build command: (dejar vacío)
   - Publish directory: `.`
6. Click "Deploy site"

### Opción 2: Deploy desde CLI

```bash
npm i -g netlify-cli
netlify deploy --prod
```

### Opción 3: Drag & Drop

Arrastra la carpeta del proyecto a [app.netlify.com/drop](https://app.netlify.com/drop)

## 🔧 Configuración de Supabase

Las credenciales ya están en el código, pero si quieres usar variables de entorno:

**En Netlify:**
1. Ve a Site settings → Environment variables
2. Agrega (opcional, ya están hardcoded):
   ```
   SUPABASE_URL=https://fbhdpwedkdbyectmieeh.supabase.co
   SUPABASE_ANON_KEY=tu-key
   ```

## 📱 Acceso

Una vez deployed, tendrás URLs como:
- **Production:** `https://hq-control-center.netlify.app`
- **Custom Domain:** `https://hq.difortuna.com` (opcional)

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

Netlify desplegará automáticamente.

## 🎯 URLs del Proyecto

- **GitHub:** https://github.com/difortunastudio/HQ-ControlCenter
- **Netlify:** https://app.netlify.com (tu dashboard)
- **Supabase:** https://supabase.com/dashboard

---

**Stack:** HTML + Supabase + Netlify  
**Última actualización:** Febrero 2026
