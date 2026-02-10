# Configuración de Netlify Corregida

## Cambios Realizados (28 de Enero 2025)

### 1. **netlify.toml** - Configuración de Publicación Corregida

**PROBLEMA ANTERIOR:**
- `publish = "."` publicaba desde el directorio raíz
- Los redirects apuntaban a `/files/control-center-final.html`
- `force = false` podía causar conflictos de caché

**SOLUCIÓN:**
```toml
[build]
  publish = "files"  # ← Ahora publica directamente desde /files
  command = ""

[[redirects]]
  from = "/"
  to = "/control-center-final.html"  # ← Ruta relativa al publish directory
  status = 200
  force = true  # ← Forzar redirección, evitar caché

[[redirects]]
  from = "/*"
  to = "/control-center-final.html"
  status = 200
  force = true
```

### 2. **control-center-final.html** - Meta Tags Anti-Caché

**AÑADIDO:**
```html
<head>
  <!-- Prevenir caché del navegador -->
  <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Expires" content="0">
</head>
```

### 3. **netlify.toml** - Headers de Cache Control

**AÑADIDO:**
```toml
[[headers]]
  for = "/*"
  [headers.values]
    Cache-Control = "no-cache, no-store, must-revalidate"
    Pragma = "no-cache"
    Expires = "0"
```

## Verificación del Deploy

### 1. Esperar a que Netlify termine el build
- Ve a https://app.netlify.com/sites/[tu-site]/deploys
- Espera a que el deploy más reciente muestre "Published"
- Tiempo estimado: 1-3 minutos

### 2. Limpiar Caché del Navegador
**Opción 1 - Hard Refresh:**
- Chrome/Edge: `Cmd + Shift + R` (macOS)
- Firefox: `Cmd + Shift + R` (macOS)

**Opción 2 - DevTools:**
1. Abre DevTools (F12 o Cmd + Option + I)
2. Click derecho en el botón de reload
3. Selecciona "Empty Cache and Hard Reload"

**Opción 3 - Modo Incógnito:**
1. Abre una ventana de incógnito/privada
2. Ve a https://silenthub.es
3. Verifica que se muestre la pantalla de login

### 3. Verificar en Netlify que el archivo correcto está desplegado
```bash
# Ver el archivo desplegado
curl https://silenthub.es/ | head -20
```

Deberías ver:
```html
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Prevenir caché del navegador -->
  <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
  ...
```

### 4. Verificar que la autenticación funciona
1. Abre https://silenthub.es en modo incógnito
2. **ESPERADO:** Pantalla de login visible, contenido oculto
3. Introduce email y contraseña
4. **ESPERADO:** Tras login exitoso, se muestra el Control Center

### 5. Si aún se ve la app sin login

**A. Verificar en Netlify:**
- Settings > Build & Deploy > Deploy Settings
- Confirmar que "Publish directory" = `files`

**B. Limpiar caché de Netlify:**
- Deploys > Trigger deploy > Clear cache and deploy site

**C. Verificar RLS en Supabase:**
- Ve a Supabase Dashboard
- Table Editor > Policies
- Confirma que todas las tablas tienen RLS activado

## Por Qué Esto Soluciona el Problema

### Antes:
1. `publish = "."` → Netlify servía desde raíz
2. Redirects a `/files/control-center-final.html` → Posible caché o conflicto
3. Sin headers anti-caché → Navegadores cacheaban versión antigua

### Ahora:
1. `publish = "files"` → Netlify sirve directamente control-center-final.html
2. Redirects con `force = true` → Evita conflictos
3. Meta tags y headers anti-caché → Fuerza recarga en cada visita
4. El CSS `body { visibility: hidden; }` garantiza que nada se muestre hasta `checkAuth()`

## Monitoreo Post-Deploy

### Verificar Headers HTTP:
```bash
curl -I https://silenthub.es/
```

Deberías ver:
```
HTTP/2 200
cache-control: no-cache, no-store, must-revalidate
pragma: no-cache
expires: 0
x-frame-options: DENY
...
```

### Verificar en DevTools:
1. Abre DevTools > Network
2. Recarga la página
3. Click en el documento HTML
4. Headers > Response Headers
5. Confirma `Cache-Control: no-cache, no-store, must-revalidate`

## Próximos Pasos

1. ✅ Deploy completo en Netlify
2. ⏳ Esperar propagación (1-3 minutos)
3. ⏳ Verificar en modo incógnito
4. ⏳ Confirmar login funcional
5. ⏳ Validar que RLS protege los datos en Supabase

## Contacto y Soporte

Si persiste el problema después de:
- Esperar 5 minutos tras el deploy
- Limpiar caché completamente
- Probar en modo incógnito

**Posibles causas adicionales:**
1. Propagación DNS aún en proceso (puede tardar hasta 48h)
2. CDN/proxy intermedio cacheando (poco probable con headers actuales)
3. Problema con las credenciales de Supabase en el archivo HTML

**Siguiente diagnóstico:**
- Revisar console.log en DevTools durante el login
- Verificar que `supabase.auth.getSession()` retorna null antes del login
- Confirmar que `showMainApp()` solo se llama tras autenticación exitosa
