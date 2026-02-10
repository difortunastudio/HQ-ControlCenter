# 🌐 Configuración DNS y Deploy - SilentHub

**Fecha:** 10 de febrero de 2026  
**Dominio:** silenthub.es  
**Deploy:** Netlify (beamish-genie-f1e9a2.netlify.app)

---

## ✅ CONFIGURACIÓN COMPLETADA

### 1. DNS en GoDaddy

#### Registros configurados:

| Tipo  | Nombre | Valor | TTL | Estado |
|-------|--------|-------|-----|--------|
| A | @ | 75.2.60.5 | 600 segundos | ✅ Configurado |
| CNAME | www | beamish-genie-f1e9a2.netlify.app | 1 Hora | ✅ Configurado |

**Notas:**
- Eliminado registro CNAME antiguo (www → silenthub.es) que causaba conflicto
- Ambos dominios (con y sin www) ahora apuntan a Netlify

---

### 2. Configuración en Netlify

#### Dominios:
- **Principal:** silenthub.es
- **Alias:** www.silenthub.es (redirige automáticamente)

#### Estado:
- ⏳ DNS verification en progreso
- ⏳ SSL/TLS certificate en provisión
- ✅ Deploy configurado desde GitHub

---

## 🔐 SEGURIDAD

### Autenticación:
- **Usuario:** silenthub_admin
- **Password:** SH2026_SecureAccess!
- **Sesión válida:** 24 horas
- **Almacenamiento:** localStorage (navegador)

### Supabase:
- **Anon Key:** ✅ Segura (no compartida)
- **RLS:** ⚠️ Pendiente configurar (ver SECURITY-CHECKLIST.md)

---

## 📋 PRÓXIMOS PASOS

### Inmediatos (0-5 minutos):
1. ✅ Esperar que termine el deploy en Netlify
2. ⏳ Esperar propagación DNS (5-30 minutos)
3. ⏳ Verificar que SSL/TLS se active

### Verificación (después de 5-10 minutos):
1. **Abrir en modo incógnito:** https://silenthub.es o http://silenthub.es
2. **Verificar que pida login** (credenciales arriba)
3. **Probar que funciona el Control Center**
4. **Verificar que www.silenthub.es también funcione**

### Opcionales (después del deploy):
- [ ] Cambiar contraseña a una más personal
- [ ] Configurar RLS en Supabase (máxima seguridad)
- [ ] Configurar backup automático de datos
- [ ] Documentar credenciales en gestor de contraseñas (1Password, etc.)

---

## 🧪 COMANDOS DE VERIFICACIÓN

### Verificar propagación DNS:
```bash
# Verificar registro A
dig silenthub.es +short

# Verificar registro CNAME
dig www.silenthub.es +short

# O usar herramientas online:
# - https://dnschecker.org
# - https://www.whatsmydns.net
```

### Limpiar caché del navegador:
```
Chrome/Edge: Cmd+Shift+R (Mac) o Ctrl+Shift+R (Windows)
Safari: Cmd+Option+E y luego Cmd+R
Firefox: Cmd+Shift+R (Mac) o Ctrl+F5 (Windows)
```

---

## 🔗 ENLACES IMPORTANTES

### Deploy y Dominio:
- **Netlify Site:** https://app.netlify.com/sites/beamish-genie-f1e9a2
- **Netlify Deploys:** https://app.netlify.com/sites/beamish-genie-f1e9a2/deploys
- **Domain Settings:** https://app.netlify.com/sites/beamish-genie-f1e9a2/settings/domain

### DNS:
- **GoDaddy DNS:** https://dcc.godaddy.com/control/silenthub.es/dns

### Supabase:
- **Dashboard:** https://supabase.com/dashboard/project/fbhdpwedkdbyectmieeh
- **Logs:** https://supabase.com/dashboard/project/fbhdpwedkdbyectmieeh/logs/explorer

### GitHub:
- **Repositorio:** https://github.com/difortunastudio/HQ-ControlCenter

---

## 🎯 URLs FINALES

Una vez todo propagado:

- **Producción:** https://silenthub.es
- **Con www:** https://www.silenthub.es (redirige a la principal)
- **Netlify (backup):** https://beamish-genie-f1e9a2.netlify.app

---

## 📊 TIMELINE DEL DEPLOY

| Hora | Acción | Estado |
|------|--------|--------|
| ~12:00 | Configuración DNS en GoDaddy | ✅ Completado |
| ~12:10 | Eliminación registro conflictivo | ✅ Completado |
| ~12:15 | Configuración dominio en Netlify | ✅ Completado |
| ~12:20 | Re-deploy con autenticación | ✅ En progreso |
| ~12:25 | Propagación DNS estimada | ⏳ Esperando |
| ~12:30 | SSL/TLS provisión | ⏳ Esperando |

---

## ❓ TROUBLESHOOTING

### Si el sitio no carga después de 30 minutos:
1. Verificar en Netlify Deploys que el último deploy sea exitoso
2. Limpiar caché del navegador completamente
3. Probar desde otro dispositivo/navegador
4. Verificar DNS con `dig` o dnschecker.org

### Si pide login pero no acepta las credenciales:
1. Verificar que usas: `silenthub_admin` / `SH2026_SecureAccess!`
2. Revisar consola del navegador (F12) por errores
3. Verificar que el archivo desplegado sea el correcto

### Si NO pide login (se abre directo):
1. Abrir en modo incógnito/privado
2. Forzar recarga con Cmd+Shift+R
3. Esperar 5 minutos más (caché de Netlify)
4. Verificar último commit en GitHub

---

## 📝 NOTAS TÉCNICAS

### Configuración de Netlify (netlify.toml):
```toml
[[redirects]]
  from = "/*"
  to = "/files/control-center-final.html"
  status = 200
```

### Sistema de autenticación:
- Verificación en `DOMContentLoaded`
- Función `checkAuth()` valida localStorage
- Sesión expira en 24 horas
- Logout limpia localStorage y recarga

### Sincronización de datos:
- **Local:** localStorage (inmediato)
- **Remoto:** Supabase (en cada cambio)
- **Modo dual:** Funciona offline con localStorage

---

## ✅ CHECKLIST FINAL

Antes de considerar el deploy completo:

- [x] Código subido a GitHub
- [x] DNS configurado en GoDaddy
- [x] Dominio agregado en Netlify
- [x] Deploy ejecutado
- [ ] DNS propagado (esperar 5-30 min)
- [ ] SSL/TLS activo
- [ ] Login funcionando correctamente
- [ ] Control Center accesible
- [ ] Datos sincronizando con Supabase

---

**🎉 Una vez verificado todo, tu Control Center estará live en silenthub.es!**

**Siguiente paso:** Espera 5-10 minutos y prueba acceder en modo incógnito.
