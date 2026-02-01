# Configuración de Supabase para Control Center

## 🎯 Resumen

Tu Control Center ahora tiene integración completa con Supabase para base de datos real en la nube con sincronización en tiempo real. Sigue estos pasos para configurarlo.

## 📋 Prerrequisitos

1. **Cuenta de Supabase**: Ve a [supabase.com](https://supabase.com) y crea una cuenta gratuita
2. **Hosting**: Tu app debe estar desplegada (Netlify, Vercel, etc.) para usar Supabase

## 🚀 Paso 1: Crear Proyecto en Supabase

1. Ve a [app.supabase.com](https://app.supabase.com)
2. Haz clic en "New project"
3. Selecciona tu organización
4. Nombra tu proyecto: "control-center" o similar
5. Crea una contraseña segura para la base de datos
6. Selecciona la región más cercana a ti
7. Haz clic en "Create new project"

## 🗄️ Paso 2: Crear las Tablas

Una vez que tu proyecto esté listo, ve a la sección "SQL Editor" y ejecuta este script:

```sql
-- Crear tabla de empresas
CREATE TABLE companies (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    legal_name TEXT,
    cif TEXT,
    fiscal_address TEXT,
    phone TEXT,
    email TEXT,
    tags JSONB DEFAULT '[]',
    bank_accounts JSONB DEFAULT '[]',
    emails JSONB DEFAULT '[]',
    social_media JSONB DEFAULT '[]',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear tabla de marcas
CREATE TABLE brands (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT,
    company_id TEXT REFERENCES companies(id) ON DELETE CASCADE,
    tags JSONB DEFAULT '[]',
    services TEXT,
    domain TEXT,
    domain_provider TEXT,
    domain_renewal DATE,
    hosting TEXT,
    backend TEXT,
    emails JSONB DEFAULT '[]',
    social_media JSONB DEFAULT '[]',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear tabla de tareas
CREATE TABLE tasks (
    id TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    date DATE,
    completed BOOLEAN DEFAULT FALSE,
    association TEXT,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear tabla de suscripciones
CREATE TABLE subscriptions (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    cost DECIMAL(10,2),
    plan TEXT,
    url TEXT,
    association TEXT,
    renewal_day INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear tabla de credenciales
CREATE TABLE credentials (
    id TEXT PRIMARY KEY,
    service TEXT NOT NULL,
    username TEXT,
    email TEXT,
    password TEXT,
    category TEXT,
    association TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear tabla de documentos
CREATE TABLE documents (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT,
    url TEXT,
    platform TEXT,
    association TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear tabla de memoria contable
CREATE TABLE memoria_contable (
    id TEXT PRIMARY KEY,
    company_id TEXT REFERENCES companies(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    content TEXT,
    date DATE,
    ref TEXT,
    tags JSONB DEFAULT '[]',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para mejorar rendimiento
CREATE INDEX idx_brands_company_id ON brands(company_id);
CREATE INDEX idx_memoria_company_id ON memoria_contable(company_id);
CREATE INDEX idx_tasks_date ON tasks(date);
CREATE INDEX idx_companies_created_at ON companies(created_at);
CREATE INDEX idx_brands_created_at ON brands(created_at);
```

## 🔐 Paso 3: Configurar Políticas RLS (Row Level Security)

Ejecuta también este script para configurar la seguridad:

```sql
-- Habilitar RLS en todas las tablas
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE credentials ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE memoria_contable ENABLE ROW LEVEL SECURITY;

-- Crear políticas para permitir acceso público (puedes hacer esto más restrictivo después)
CREATE POLICY "Permitir lectura pública" ON companies FOR SELECT USING (true);
CREATE POLICY "Permitir escritura pública" ON companies FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir actualización pública" ON companies FOR UPDATE USING (true);
CREATE POLICY "Permitir eliminación pública" ON companies FOR DELETE USING (true);

CREATE POLICY "Permitir lectura pública" ON brands FOR SELECT USING (true);
CREATE POLICY "Permitir escritura pública" ON brands FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir actualización pública" ON brands FOR UPDATE USING (true);
CREATE POLICY "Permitir eliminación pública" ON brands FOR DELETE USING (true);

CREATE POLICY "Permitir lectura pública" ON tasks FOR SELECT USING (true);
CREATE POLICY "Permitir escritura pública" ON tasks FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir actualización pública" ON tasks FOR UPDATE USING (true);
CREATE POLICY "Permitir eliminación pública" ON tasks FOR DELETE USING (true);

CREATE POLICY "Permitir lectura pública" ON subscriptions FOR SELECT USING (true);
CREATE POLICY "Permitir escritura pública" ON subscriptions FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir actualización pública" ON subscriptions FOR UPDATE USING (true);
CREATE POLICY "Permitir eliminación pública" ON subscriptions FOR DELETE USING (true);

CREATE POLICY "Permitir lectura pública" ON credentials FOR SELECT USING (true);
CREATE POLICY "Permitir escritura pública" ON credentials FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir actualización pública" ON credentials FOR UPDATE USING (true);
CREATE POLICY "Permitir eliminación pública" ON credentials FOR DELETE USING (true);

CREATE POLICY "Permitir lectura pública" ON documents FOR SELECT USING (true);
CREATE POLICY "Permitir escritura pública" ON documents FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir actualización pública" ON documents FOR UPDATE USING (true);
CREATE POLICY "Permitir eliminación pública" ON documents FOR DELETE USING (true);

CREATE POLICY "Permitir lectura pública" ON memoria_contable FOR SELECT USING (true);
CREATE POLICY "Permitir escritura pública" ON memoria_contable FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir actualización pública" ON memoria_contable FOR UPDATE USING (true);
CREATE POLICY "Permitir eliminación pública" ON memoria_contable FOR DELETE USING (true);
```

## ⚙️ Paso 4: Obtener las Credenciales ✅

1. Ve a **Settings > API** en tu proyecto de Supabase
2. Copia el **Project URL**: `https://fbhdpwedkdbyectmieeh.supabase.co`
3. Copia la **anon/public key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

**✅ COMPLETADO** - Ya están configuradas en tu aplicación.

## 🔧 Paso 5: Configurar tu Aplicación ✅

~~Abre tu archivo `control-center-final.html` y busca esta sección cerca del inicio del JavaScript:~~

```javascript
// Configuración de Supabase - ✅ YA CONFIGURADO
const SUPABASE_CONFIG = {
  enabled: true, // ✅ Supabase activado
  url: 'https://fbhdpwedkdbyectmieeh.supabase.co', // ✅ Tu URL configurada
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...', // ✅ Tu clave configurada
  realTimeSync: true // ✅ Sincronización activada
};
```

**✅ COMPLETADO** - Tu aplicación ya está configurada con Supabase.

## 🌍 Paso 6: Desplegar tu Aplicación

**Importante**: Supabase solo funciona desde dominios HTTPS. No funcionará desde archivos locales (`file://`).

### Opción 1: Netlify (Recomendado)
1. Ve a [netlify.com](https://netlify.com)
2. Arrastra tu archivo HTML a la zona de drop
3. Tu app estará disponible en un dominio `.netlify.app`

### Opción 2: Vercel
1. Ve a [vercel.com](https://vercel.com)
2. Importa tu proyecto o arrastra el archivo
3. Tu app estará disponible en un dominio `.vercel.app`

### Opción 3: GitHub Pages
1. Sube tu archivo a un repositorio de GitHub
2. Ve a Settings > Pages
3. Activa GitHub Pages desde la rama `main`

## ✅ Paso 7: Verificar la Integración

Una vez desplegado:

1. Abre tu aplicación desde el dominio público
2. Abre las herramientas de desarrollo (F12)
3. Ve a la pestaña **Console**
4. Deberías ver: "✅ Supabase inicializado correctamente"
5. Crea una empresa o marca de prueba
6. Ve a tu dashboard de Supabase > Table editor
7. Verifica que los datos aparezcan en las tablas

## 🔄 Características Disponibles

Con Supabase activado tendrás:

- ✅ **Sincronización en tiempo real** entre dispositivos
- ✅ **Backup automático** en la nube
- ✅ **Acceso desde cualquier dispositivo** con internet
- ✅ **Fallback a localStorage** si hay problemas de conexión
- ✅ **Escalabilidad** para múltiples usuarios (futuro)

## 🛡️ Seguridad Avanzada (Opcional)

Para uso en producción, considera implementar:

1. **Autenticación de Supabase** en lugar de la básica actual
2. **Políticas RLS más restrictivas** por usuario
3. **Variables de entorno** para las credenciales
4. **Cifrado de credenciales** sensibles

## 🚨 Troubleshooting

### Error: "Supabase no configurado"
- Verifica que `enabled: true` en la configuración
- Confirma que URL y anonKey están correctos

### Error de CORS
- Asegúrate de usar HTTPS (no `file://`)
- Verifica que el dominio esté en la lista permitida de Supabase

### No se guardan los datos
- Revisa la consola del navegador para errores
- Verifica que las tablas existen en Supabase
- Confirma que las políticas RLS están configuradas

### Datos duplicados
- Esto puede pasar durante la migración inicial
- Puedes limpiar las tablas y importar desde localStorage

## 💡 Próximos Pasos

1. **Migración de datos existentes**: Los datos de localStorage se mantendrán como fallback
2. **Múltiples usuarios**: Implementar autenticación de Supabase
3. **Backups**: Exportar/importar datos en formato JSON
4. **Analytics**: Dashboards avanzados con los datos de Supabase

## 🆘 Soporte

Si tienes problemas:

1. Revisa la consola del navegador para errores específicos
2. Verifica que todas las tablas se crearon correctamente
3. Confirma que las políticas RLS están activas
4. Prueba desde un navegador privado/incógnito

¡Listo! Ahora tienes un Control Center con base de datos real en la nube. 🚀
