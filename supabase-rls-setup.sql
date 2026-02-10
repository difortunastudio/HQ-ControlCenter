-- ============================================
-- 🔒 SEGURIDAD RLS PARA SILENTHUB
-- ============================================
-- Ejecutar en: Supabase SQL Editor
-- Dashboard: https://supabase.com/dashboard/project/fbhdpwedkdbyectmieeh
-- ============================================

-- ============================================
-- PASO 1: ACTIVAR RLS EN TODAS LAS TABLAS
-- ============================================

ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE credentials ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- ============================================
-- PASO 2: ELIMINAR POLÍTICAS ANTIGUAS (si existen)
-- ============================================

DROP POLICY IF EXISTS "Enable all for authenticated users" ON companies;
DROP POLICY IF EXISTS "Enable all for authenticated users" ON brands;
DROP POLICY IF EXISTS "Enable all for authenticated users" ON tasks;
DROP POLICY IF EXISTS "Enable all for authenticated users" ON subscriptions;
DROP POLICY IF EXISTS "Enable all for authenticated users" ON credentials;
DROP POLICY IF EXISTS "Enable all for authenticated users" ON documents;

DROP POLICY IF EXISTS "temp_policy" ON companies;
DROP POLICY IF EXISTS "temp_policy" ON brands;
DROP POLICY IF EXISTS "temp_policy" ON tasks;
DROP POLICY IF EXISTS "temp_policy" ON subscriptions;
DROP POLICY IF EXISTS "temp_policy" ON credentials;
DROP POLICY IF EXISTS "temp_policy" ON documents;

-- ============================================
-- OPCIÓN A: POLÍTICAS PERMISIVAS TEMPORALES
-- ============================================
-- ⚠️ USAR SOLO SI HAS ROTADO LA ANON KEY
-- ⚠️ Y LA KEY NO ESTÁ COMPARTIDA PÚBLICAMENTE
-- ============================================

-- Companies
CREATE POLICY "allow_all_companies" ON companies
  FOR ALL USING (true) WITH CHECK (true);

-- Brands
CREATE POLICY "allow_all_brands" ON brands
  FOR ALL USING (true) WITH CHECK (true);

-- Tasks
CREATE POLICY "allow_all_tasks" ON tasks
  FOR ALL USING (true) WITH CHECK (true);

-- Subscriptions
CREATE POLICY "allow_all_subscriptions" ON subscriptions
  FOR ALL USING (true) WITH CHECK (true);

-- Credentials
CREATE POLICY "allow_all_credentials" ON credentials
  FOR ALL USING (true) WITH CHECK (true);

-- Documents
CREATE POLICY "allow_all_documents" ON documents
  FOR ALL USING (true) WITH CHECK (true);

-- ============================================
-- OPCIÓN B: POLÍTICAS CON AUTENTICACIÓN
-- ============================================
-- 🔒 MÁS SEGURO - Requiere Supabase Auth
-- ============================================
-- ⚠️ COMENTADO POR DEFECTO
-- ⚠️ Descomentar si implementas Supabase Auth
-- ============================================

/*
-- Companies
CREATE POLICY "auth_users_companies" ON companies
  FOR ALL USING (auth.uid() IS NOT NULL) WITH CHECK (auth.uid() IS NOT NULL);

-- Brands
CREATE POLICY "auth_users_brands" ON brands
  FOR ALL USING (auth.uid() IS NOT NULL) WITH CHECK (auth.uid() IS NOT NULL);

-- Tasks
CREATE POLICY "auth_users_tasks" ON tasks
  FOR ALL USING (auth.uid() IS NOT NULL) WITH CHECK (auth.uid() IS NOT NULL);

-- Subscriptions
CREATE POLICY "auth_users_subscriptions" ON subscriptions
  FOR ALL USING (auth.uid() IS NOT NULL) WITH CHECK (auth.uid() IS NOT NULL);

-- Credentials
CREATE POLICY "auth_users_credentials" ON credentials
  FOR ALL USING (auth.uid() IS NOT NULL) WITH CHECK (auth.uid() IS NOT NULL);

-- Documents
CREATE POLICY "auth_users_documents" ON documents
  FOR ALL USING (auth.uid() IS NOT NULL) WITH CHECK (auth.uid() IS NOT NULL);
*/

-- ============================================
-- OPCIÓN C: POLÍTICAS POR USUARIO ESPECÍFICO
-- ============================================
-- 🔐 MUY SEGURO - Un solo usuario puede acceder
-- ============================================
-- ⚠️ COMENTADO POR DEFECTO
-- ⚠️ Requiere crear usuario en Supabase Auth primero
-- ⚠️ Reemplazar 'YOUR_USER_UUID' con el UUID real
-- ============================================

/*
-- Primero, crea un usuario en:
-- Dashboard > Authentication > Users > Add user
-- Email: admin@silenthub.com
-- Password: [tu password seguro]
-- Copia el UUID del usuario creado

-- Luego ejecuta estas políticas:

CREATE POLICY "single_user_companies" ON companies
  FOR ALL USING (auth.uid() = 'YOUR_USER_UUID'::uuid)
  WITH CHECK (auth.uid() = 'YOUR_USER_UUID'::uuid);

CREATE POLICY "single_user_brands" ON brands
  FOR ALL USING (auth.uid() = 'YOUR_USER_UUID'::uuid)
  WITH CHECK (auth.uid() = 'YOUR_USER_UUID'::uuid);

CREATE POLICY "single_user_tasks" ON tasks
  FOR ALL USING (auth.uid() = 'YOUR_USER_UUID'::uuid)
  WITH CHECK (auth.uid() = 'YOUR_USER_UUID'::uuid);

CREATE POLICY "single_user_subscriptions" ON subscriptions
  FOR ALL USING (auth.uid() = 'YOUR_USER_UUID'::uuid)
  WITH CHECK (auth.uid() = 'YOUR_USER_UUID'::uuid);

CREATE POLICY "single_user_credentials" ON credentials
  FOR ALL USING (auth.uid() = 'YOUR_USER_UUID'::uuid)
  WITH CHECK (auth.uid() = 'YOUR_USER_UUID'::uuid);

CREATE POLICY "single_user_documents" ON documents
  FOR ALL USING (auth.uid() = 'YOUR_USER_UUID'::uuid)
  WITH CHECK (auth.uid() = 'YOUR_USER_UUID'::uuid);
*/

-- ============================================
-- VERIFICACIÓN
-- ============================================

-- Ver RLS status
SELECT schemaname, tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
  AND tablename IN ('companies', 'brands', 'tasks', 'subscriptions', 'credentials', 'documents');

-- Ver políticas activas
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('companies', 'brands', 'tasks', 'subscriptions', 'credentials', 'documents');

-- ============================================
-- NOTAS IMPORTANTES
-- ============================================

/*
📌 RECOMENDACIONES:

1. INICIO RÁPIDO (5 min):
   - Ejecutar PASO 1 y PASO 2
   - Ejecutar OPCIÓN A (si rotaste la key)
   - ⚠️ Cambiar a OPCIÓN B o C cuando sea posible

2. SEGURIDAD MEDIA (30 min):
   - Ejecutar PASO 1 y PASO 2
   - Implementar Supabase Auth en el frontend
   - Ejecutar OPCIÓN B

3. MÁXIMA SEGURIDAD (1 hora):
   - Ejecutar PASO 1 y PASO 2
   - Crear usuario en Supabase Auth
   - Implementar Supabase Auth en el frontend
   - Ejecutar OPCIÓN C con tu UUID

📌 TESTING:

Después de aplicar RLS, prueba:

-- Como usuario anónimo (debería fallar con OPCIÓN B y C)
SELECT * FROM companies;

-- Como usuario autenticado (debería funcionar)
-- Usa el cliente de Supabase autenticado

📌 TROUBLESHOOTING:

Si después de aplicar RLS no puedes acceder a los datos:

1. Verifica que las políticas estén activas:
   SELECT * FROM pg_policies WHERE tablename = 'companies';

2. Verifica que el usuario esté autenticado:
   SELECT auth.uid();

3. Desactiva RLS temporalmente para debug:
   ALTER TABLE companies DISABLE ROW LEVEL SECURITY;

4. Reactiva cuando arregles el problema:
   ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
*/

-- ============================================
-- FIN DE CONFIGURACIÓN
-- ============================================
