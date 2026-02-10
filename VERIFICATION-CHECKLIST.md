# ✅ Checklist de Verificación Post-Deploy

## 🔧 Cambios Aplicados
- [x] Configuración de Netlify corregida (`publish = "files"`)
- [x] Redirects con `force = true`
- [x] Meta tags anti-caché añadidas
- [x] Headers Cache-Control en netlify.toml
- [x] Commit y push realizados
- [x] Deploy triggerado en Netlify

## ⏳ Verificaciones Pendientes (EJECUTAR EN ORDEN)

### 1. Estado del Deploy en Netlify
**Acción:**
1. Ir a https://app.netlify.com/sites/[tu-site]/deploys
2. Verificar que el último deploy (commit `1af301a`) está "Published"
3. Anotar la hora de publicación: ________________

**Status:** ⬜ Pendiente

---

### 2. Limpieza de Caché Local
**Acción:**
1. Abrir Chrome/Safari en modo incógnito
2. Ir a https://silenthub.es
3. Verificar que NO se ve el contenido de la app, solo login

**Resultado esperado:** Solo pantalla de login visible

**Status:** ⬜ Pendiente

---

### 3. Verificar Archivo Desplegado
**Comando:**
```bash
curl -s https://silenthub.es/ | head -20
```

**Resultado esperado:** Debe contener:
```html
<!-- Prevenir caché del navegador -->
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
```

**Status:** ⬜ Pendiente

---

### 4. Verificar Headers HTTP
**Comando:**
```bash
curl -I https://silenthub.es/
```

**Resultado esperado:** Headers deben incluir:
```
cache-control: no-cache, no-store, must-revalidate
pragma: no-cache
expires: 0
```

**Status:** ⬜ Pendiente

---

### 5. Prueba de Login Funcional
**Acción:**
1. En modo incógnito, ir a https://silenthub.es
2. Introducir email y contraseña
3. Verificar que tras login exitoso se muestra el Control Center
4. Verificar que los datos cargan correctamente

**Status:** ⬜ Pendiente

---

### 6. Prueba de Sesión Persistente
**Acción:**
1. Tras login exitoso, cerrar el navegador
2. Abrir de nuevo y volver a https://silenthub.es
3. Verificar que la sesión persiste (no pide login de nuevo)

**Status:** ⬜ Pendiente

---

### 7. Prueba de Logout
**Acción:**
1. Estando logueado, hacer click en "Cerrar Sesión"
2. Verificar que se oculta el contenido y se muestra login
3. Verificar que localStorage se limpia

**Status:** ⬜ Pendiente

---

## 🔍 Diagnóstico si FALLA

### Si aún se ve la app sin login:

#### A. Verificar configuración de Netlify
```bash
# Ver netlify.toml desplegado
curl -s https://silenthub.es/netlify.toml
```

**Si devuelve 404:** ✅ Correcto (netlify.toml no debe ser público)
**Si devuelve el archivo:** ❌ Problema: publish directory incorrecto

#### B. Limpiar caché de Netlify
1. Netlify Dashboard > Deploys
2. Trigger deploy > **Clear cache and deploy site**
3. Esperar 2-3 minutos
4. Re-verificar

#### C. Verificar JavaScript en DevTools
1. Abrir DevTools > Console
2. Recargar https://silenthub.es
3. Buscar logs de `checkAuth()`
4. Verificar que `supabase.auth.getSession()` se ejecuta

**Logs esperados:**
```
Iniciando checkAuth...
Usuario: null  (antes de login)
```

#### D. Verificar RLS en Supabase
1. Supabase Dashboard > Table Editor
2. Click en cada tabla > Policies
3. Confirmar: RLS enabled + políticas SELECT/INSERT/UPDATE/DELETE

#### E. Verificar credenciales de Supabase
1. Abrir /files/control-center-final.html
2. Buscar línea ~3440:
```javascript
const supabase = createClient(
  'https://jhunfyxlwovmvofqgtri.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
)
```
3. Confirmar que la URL y anon key son correctos
4. Probar login directo en Supabase Dashboard > Authentication

---

## 📊 Resumen de Estado

**Fecha de último deploy:** 28 de Enero 2025
**Commit:** `1af301a` - "fix: Corregir configuración de Netlify y prevenir caché"

**Configuración actual:**
- Publish directory: `files`
- Redirects: force = true
- Cache-Control: no-cache, no-store, must-revalidate
- RLS: Activado en todas las tablas
- Autenticación: body.visibility = hidden hasta login

**Dominios:**
- Principal: https://silenthub.es
- Netlify: https://[tu-site].netlify.app

---

## 🎯 Criterios de Éxito

✅ **Deploy exitoso si:**
1. En modo incógnito, https://silenthub.es muestra SOLO pantalla de login
2. El contenido del Control Center está oculto (body no visible)
3. Tras login exitoso, se muestra el Control Center completo
4. Los datos cargan correctamente desde Supabase
5. La sesión persiste tras cerrar y abrir el navegador
6. El logout oculta el contenido y muestra login de nuevo

❌ **Falla si:**
1. Se ve el contenido de la app sin estar logueado
2. La pantalla de login no aparece
3. El login no funciona (error de credenciales o RLS)
4. Los datos no cargan desde Supabase

---

## 📝 Notas Adicionales

- **Tiempo de propagación DNS:** Si acabas de configurar el dominio, puede tardar hasta 48h
- **Caché de CDN:** Netlify tiene CDN, puede tardar 1-5 minutos en actualizar
- **Caché del navegador:** Siempre probar en modo incógnito tras cambios
- **RLS en Supabase:** Si falla el acceso a datos, revisar políticas RLS

---

## 🚀 Próximos Pasos (Tras Verificación Exitosa)

1. Documentar configuración final en README.md
2. Actualizar SECURITY-SUMMARY.txt con estado actual
3. Crear backup del proyecto
4. Configurar monitoring/alertas (opcional)
5. Implementar sistema de logs (opcional)

---

**Última actualización:** 28 de Enero 2025, 23:45 CET
**Responsable:** Control Center Deploy Team
**Prioridad:** 🔴 CRÍTICA - Verificar en las próximas horas
