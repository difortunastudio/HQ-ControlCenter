# 🔒 Security Checklist - Pre-Deploy para SilentHub

**Fecha:** 10 de febrero de 2026  
**Estado:** 🚨 ACCIÓN REQUERIDA ANTES DE DEPLOY

---

## ✅ CAMBIOS REALIZADOS

### 1. ✅ Credenciales de Login Actualizadas

```javascript
// ANTES (inseguro)
username: 'admin'
password: 'control2026'

// AHORA (mejorado)
username: 'silenthub_admin'
password: 'SH2026_SecureAccess!'
```

**⚠️ IMPORTANTE:** Cambia esta contraseña a algo más personal y seguro antes del deploy final.

---

## ✅ Supabase Key - NO REQUIERE ROTACIÓN

### Estado: SEGURO
- ✅ La anon key NO ha sido compartida
- ✅ El repositorio es privado
- ✅ Puedes mantener la key actual

### ⚠️ Solo rotar si:
- Compartes el repositorio públicamente
- Sospechas de acceso no autorizado
- Como buena práctica cada 6-12 meses

### Cómo rotar la key (si fuera necesario):

1. **Ve a Supabase Dashboard:**
   ```
   https://supabase.com/dashboard/project/fbhdpwedkdbyectmieeh/settings/api
   ```

2. **Regenera la Anon Key:**
   - Sección: "Project API keys"
   - Click en "Reset" en la anon/public key
   - Copia la nueva key

3. **Actualiza en el código:**
   ```javascript
   // En control-center-final.html línea ~808
   anonKey: 'TU_NUEVA_KEY_AQUÍ'
   ```

4. **Actualiza también en:**
   - `supabase-setup.sql` (si tiene la key)
   - Cualquier documentación
   - Variables de entorno de deploy

---

## 🔐 RLS (Row Level Security) - CRÍTICO

### ⚠️ ESTADO ACTUAL
El proyecto actualmente usa **políticas permisivas** que permiten acceso público a los datos.

### 🎯 CONFIGURACIÓN RECOMENDADA

#### Opción A: Autenticación Simple (Recomendado para MVP)

```sql
-- 1. Desactivar acceso anónimo total
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE credentials ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- 2. Crear política básica: solo usuarios autenticados
CREATE POLICY "Autenticados pueden ver todo" ON companies
  FOR ALL USING (auth.uid() IS NOT NULL);

CREATE POLICY "Autenticados pueden ver todo" ON brands
  FOR ALL USING (auth.uid() IS NOT NULL);

CREATE POLICY "Autenticados pueden ver todo" ON tasks
  FOR ALL USING (auth.uid() IS NOT NULL);

CREATE POLICY "Autenticados pueden ver todo" ON subscriptions
  FOR ALL USING (auth.uid() IS NOT NULL);

CREATE POLICY "Autenticados pueden ver todo" ON credentials
  FOR ALL USING (auth.uid() IS NOT NULL);

CREATE POLICY "Autenticados pueden ver todo" ON documents
  FOR ALL USING (auth.uid() IS NOT NULL);
```

#### Opción B: Sin RLS pero con Service Key (Solo backend)

Si prefieres mantener la autenticación actual del frontend:

1. **Crear backend API simple** (Node.js/Deno)
2. **Usar Service Role Key** en el backend (nunca en frontend)
3. **Frontend se autentica con tu sistema actual**
4. **Backend maneja Supabase con permisos totales**

#### Opción C: Migrar a Supabase Auth (Más seguro)

```javascript
// 1. Eliminar sistema de auth actual
// 2. Implementar Supabase Auth

// En el login:
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'admin@silenthub.com',
  password: 'tu_password_seguro'
});

// Las políticas RLS automáticamente reconocerán el usuario
```

---

## 📋 CHECKLIST PRE-DEPLOY

### Seguridad Mínima (IMPRESCINDIBLE)

- [x] ✅ Cambiar usuario/contraseña de login
- [x] ✅ Verificar que anon key no esté compartida
- [ ] 🔐 Configurar RLS básico en Supabase
- [ ] 🔍 Verificar que las políticas funcionen

### Seguridad Adicional (RECOMENDADO)

- [ ] 📧 Crear usuario de Supabase Auth real
- [ ] 🔑 Implementar 2FA (opcional)
- [ ] 📝 Revisar logs de acceso en Supabase
- [ ] 🚫 Limitar requests por IP (en Supabase settings)
- [ ] 🔒 Habilitar HTTPS obligatorio en dominio

### Buenas Prácticas

- [ ] 📋 Documentar credenciales en lugar seguro (1Password, LastPass)
- [ ] 🔄 Configurar rotación de passwords periódica
- [ ] 📊 Activar alertas de actividad sospechosa en Supabase
- [ ] 💾 Configurar backups automáticos en Supabase

---

## 🎯 CONFIGURACIÓN RÁPIDA RECOMENDADA

### Para deploy YA (5 minutos):

```sql
-- Ejecutar en Supabase SQL Editor:

-- 1. Activar RLS en todas las tablas
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE credentials ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- 2. Política temporal permisiva (CAMBIAR DESPUÉS)
-- ⚠️ ESTO PERMITE ACCESO A TODOS con la anon key
-- Úsalo SOLO si rotas la key y no la compartes
CREATE POLICY "temp_policy" ON companies FOR ALL USING (true);
CREATE POLICY "temp_policy" ON brands FOR ALL USING (true);
CREATE POLICY "temp_policy" ON tasks FOR ALL USING (true);
CREATE POLICY "temp_policy" ON subscriptions FOR ALL USING (true);
CREATE POLICY "temp_policy" ON credentials FOR ALL USING (true);
CREATE POLICY "temp_policy" ON documents FOR ALL USING (true);
```

### Para producción real (30 minutos):

1. **Crear usuario en Supabase Auth:**
   - Email: `admin@silenthub.com` (o tu email)
   - Password: Uno fuerte y único

2. **Actualizar código para usar Supabase Auth:**
   - Reemplazar sistema de login actual
   - Usar `supabase.auth.signInWithPassword()`

3. **Configurar RLS con auth.uid():**
   ```sql
   CREATE POLICY "Solo admin" ON companies
     FOR ALL USING (auth.uid() = 'TU_USER_UUID');
   ```

4. **Añadir columna user_id a todas las tablas** (opcional pero recomendado)

---

## 🚨 RIESGOS ACTUALES

### � MEDIO RIESGO
- **Sin RLS activo** → Datos accesibles con la anon key (pero key no compartida)
- **Sin 2FA** → Una sola barrera de seguridad
- **Sin rate limiting** → Vulnerable a brute force
- **Sin logs de auditoría** → No sabes quién accede

### 🟢 BAJO RIESGO (ya mitigado)
- ✅ Credenciales actualizadas
- ✅ Anon key NO compartida (solo tú la tienes)
- ✅ Repositorio privado
- ✅ Conexión HTTPS con Supabase
- ✅ No hay SQL injection (usamos ORM de Supabase)

---

## 📞 ACCIONES INMEDIATAS

### ANTES de hacer deploy:

```bash
# 1. Configurar RLS básico
# (ejecutar SQL en Supabase - ver supabase-rls-setup.sql)

# 2. Probar localmente
# Usuario: silenthub_admin
# Password: SH2026_SecureAccess!

# 3. Commit (si hiciste cambios)
git add .
git commit -m "🔒 Security: Configure RLS policies"
git push origin main
```

### DESPUÉS del deploy:

```bash
# 1. Verificar que el login funcione
# 2. Probar CRUD operations
# 3. Verificar que RLS esté activo
# 4. Monitorear logs en Supabase durante las primeras 24h
```

---

## 🔗 ENLACES ÚTILES

- **Supabase Dashboard:** https://supabase.com/dashboard/project/fbhdpwedkdbyectmieeh
- **API Settings:** https://supabase.com/dashboard/project/fbhdpwedkdbyectmieeh/settings/api
- **RLS Policies:** https://supabase.com/dashboard/project/fbhdpwedkdbyectmieeh/auth/policies
- **Auth Users:** https://supabase.com/dashboard/project/fbhdpwedkdbyectmieeh/auth/users
- **Logs:** https://supabase.com/dashboard/project/fbhdpwedkdbyectmieeh/logs/explorer

---

## ✅ CUANDO TODO ESTÉ LISTO

```bash
# Marca como completado
echo "✅ Seguridad verificada - Ready for production" > SECURITY-OK.txt
git add SECURITY-OK.txt
git commit -m "✅ Security checklist completed"
git push origin main

# Deploy
netlify deploy --prod
# o
vercel --prod
```

---

**Última actualización:** 10 de febrero de 2026, 12:15 PM  
**Estado:** 🚨 REQUIERE ACCIÓN - Rotar key y configurar RLS
**Prioridad:** 🔴 ALTA - Hacer antes del deploy
