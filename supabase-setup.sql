-- ============================================
-- CONTROL CENTER - SQL COMPLETO PARA SUPABASE
-- ============================================

-- Tabla de empresas
CREATE TABLE IF NOT EXISTS companies (
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

-- Tabla de marcas
CREATE TABLE IF NOT EXISTS brands (
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

-- Tabla de tareas
CREATE TABLE IF NOT EXISTS tasks (
    id TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    date DATE,
    completed BOOLEAN DEFAULT FALSE,
    association TEXT,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de suscripciones
CREATE TABLE IF NOT EXISTS subscriptions (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    cost DECIMAL(10,2),
    plan TEXT,
    url TEXT,
    association TEXT,
    renewal_day INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de credenciales
CREATE TABLE IF NOT EXISTS credentials (
    id TEXT PRIMARY KEY,
    service TEXT NOT NULL,
    username TEXT,
    email TEXT,
    password TEXT,
    category TEXT,
    association TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de documentos
CREATE TABLE IF NOT EXISTS documents (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT,
    url TEXT,
    association TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de memoria contable
CREATE TABLE IF NOT EXISTS memoria_contable (
    id TEXT PRIMARY KEY,
    company_id TEXT REFERENCES companies(id) ON DELETE CASCADE,
    year INTEGER,
    quarter TEXT,
    category TEXT,
    amount DECIMAL(12,2),
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Habilitar Row Level Security (RLS) - IMPORTANTE para seguridad
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE credentials ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE memoria_contable ENABLE ROW LEVEL SECURITY;

-- Políticas de acceso público (para desarrollo)
-- NOTA: En producción deberías usar políticas más restrictivas con autenticación

CREATE POLICY "Enable read access for all users" ON companies FOR SELECT USING (true);
CREATE POLICY "Enable insert access for all users" ON companies FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update access for all users" ON companies FOR UPDATE USING (true);
CREATE POLICY "Enable delete access for all users" ON companies FOR DELETE USING (true);

CREATE POLICY "Enable read access for all users" ON brands FOR SELECT USING (true);
CREATE POLICY "Enable insert access for all users" ON brands FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update access for all users" ON brands FOR UPDATE USING (true);
CREATE POLICY "Enable delete access for all users" ON brands FOR DELETE USING (true);

CREATE POLICY "Enable read access for all users" ON tasks FOR SELECT USING (true);
CREATE POLICY "Enable insert access for all users" ON tasks FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update access for all users" ON tasks FOR UPDATE USING (true);
CREATE POLICY "Enable delete access for all users" ON tasks FOR DELETE USING (true);

CREATE POLICY "Enable read access for all users" ON subscriptions FOR SELECT USING (true);
CREATE POLICY "Enable insert access for all users" ON subscriptions FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update access for all users" ON subscriptions FOR UPDATE USING (true);
CREATE POLICY "Enable delete access for all users" ON subscriptions FOR DELETE USING (true);

CREATE POLICY "Enable read access for all users" ON credentials FOR SELECT USING (true);
CREATE POLICY "Enable insert access for all users" ON credentials FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update access for all users" ON credentials FOR UPDATE USING (true);
CREATE POLICY "Enable delete access for all users" ON credentials FOR DELETE USING (true);

CREATE POLICY "Enable read access for all users" ON documents FOR SELECT USING (true);
CREATE POLICY "Enable insert access for all users" ON documents FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update access for all users" ON documents FOR UPDATE USING (true);
CREATE POLICY "Enable delete access for all users" ON documents FOR DELETE USING (true);

CREATE POLICY "Enable read access for all users" ON memoria_contable FOR SELECT USING (true);
CREATE POLICY "Enable insert access for all users" ON memoria_contable FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update access for all users" ON memoria_contable FOR UPDATE USING (true);
CREATE POLICY "Enable delete access for all users" ON memoria_contable FOR DELETE USING (true);

-- Índices para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_brands_company_id ON brands(company_id);
CREATE INDEX IF NOT EXISTS idx_memoria_contable_company_id ON memoria_contable(company_id);
CREATE INDEX IF NOT EXISTS idx_companies_created_at ON companies(created_at);
CREATE INDEX IF NOT EXISTS idx_tasks_completed ON tasks(completed);
CREATE INDEX IF NOT EXISTS idx_tasks_date ON tasks(date);
