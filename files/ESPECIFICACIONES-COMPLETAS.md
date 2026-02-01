# 📋 ESPECIFICACIONES COMPLETAS - CONTROL CENTER

## 🎯 RESUMEN EJECUTIVO

**Control Center** es un sistema ERP completo para gestionar tu ecosistema digital de empresas, marcas, proyectos y recursos. Diseñado para emprendedores que manejan múltiples negocios bajo una estructura holding.

---

## 🏗️ ARQUITECTURA DEL SISTEMA

### Jerarquía de datos
```
USER (tú)
├── CONFIG (perfil + personalización)
├── COMPANIES (empresas legales)
│   ├── BankAccounts (cuentas bancarias)
│   ├── CompanyEmails (correos corporativos)
│   ├── SocialMedia (redes sociales)
│   ├── MemoriaContable (diario de decisiones contables)
│   └── BRANDS (marcas/proyectos)
│       ├── Emails (correos de la marca)
│       ├── SocialMedia (redes de la marca)
│       ├── Subscriptions (suscripciones)
│       └── Documents (documentos)
├── TASKS (tareas asociadas a empresas/marcas)
├── CREDENTIALS (passwords organizados)
└── DOCUMENTS (archivos en Drive/Dropbox/Notion)
```

---

## 📦 MÓDULOS PRINCIPALES

### 1. DASHBOARD
**Función:** Centro de control con resumen ejecutivo

**Componentes:**
- ⚠️ Alertas de renovación (suscripciones + dominios < 30 días)
- 📊 Stats de tareas (hoy, completadas, pendientes)
- 🚀 Accesos rápidos (Ver Empresas, Ver Marcas, Nueva Tarea)
- 📋 Tareas de hoy (clickeables para editar)
- 🕐 Actividad reciente (últimas 5 acciones)

**Vista:** Primera página al entrar

---

### 2. EMPRESAS (Companies)
**Función:** Gestionar entidades legales

**Campos principales:**
- Nombre comercial
- Nombre legal / Razón social
- CIF/NIF
- Dirección fiscal
- Teléfono principal
- Email principal
- Etiquetas personalizadas (ej: "Activa", "Holding", "España")
- Notas generales

**Relaciones dinámicas:**
- ➕ Múltiples cuentas bancarias (banco, IBAN, propósito)
- ➕ Múltiples correos (email, propósito)
- ➕ Múltiples redes sociales (plataforma, usuario, URL)
- ➕ Múltiples marcas facturadas

**Memoria Contable:**
- Diario de decisiones y cambios contables
- Tipos: Nota, Cambio Contable, Decisión
- Campos: Título, contenido, fecha, referencia, tags
- Ordenado por fecha (más reciente primero)
- Visual: borde coloreado según tipo

**Vista detalle:**
- Header con logo, nombre, etiquetas
- Información de contacto
- Cuentas bancarias
- Correos corporativos
- Redes sociales
- Suscripciones corporativas
- Grid de marcas asociadas (con costos)
- Memoria contable completa

---

### 3. MARCAS (Brands)
**Función:** Productos, servicios, apps, proyectos

**Campos principales:**
- Nombre
- Tipo (App, Servicio, Producto, etc)
- Facturada por (empresa)
- Etiquetas personalizadas (ej: "SaaS", "Prioritario", "Q1 2026")
- Servicios que ofrece

**Infraestructura digital:**
- Dominio (ejemplo.com)
- Proveedor dominio (GoDaddy, Google Domains, Porkbun, etc)
- Fecha renovación dominio
- Hosting (Vercel, Netlify, etc)
- Backend/Database (Supabase, Firebase, etc)

**Relaciones dinámicas:**
- ➕ Múltiples correos de la marca
- ➕ Múltiples redes sociales
- Suscripciones asociadas (cálculo automático de costo mensual)
- Documentos asociados

**Vista detalle:**
- Header con logo, nombre, etiquetas, costo total/mes
- Infraestructura digital completa
- Suscripciones activas
- Servicios listados
- Correos y redes sociales
- Notas

---

### 4. TAREAS (Tasks)
**Función:** Gestión de tareas diarias

**Campos:**
- Descripción *
- Fecha *
- Asociada a: [Empresa o Marca] (opcional)
- Notas
- Estado: Completada / Pendiente (checkbox)

**Funcionalidades:**
- ✅ Marcar como completada (checkbox)
- ✏️ Editar (click en la tarea)
- 🗑️ Eliminar (botón ×)
- Click en tarea → abre modal para editar

**Vistas:**
- Dashboard: Tareas de hoy
- Vista Tareas: Organizadas en secciones (Hoy, Próximas, Pasadas)

**Cálculos automáticos:**
- Contador: Tareas de hoy
- Contador: Completadas
- Contador: Pendientes

---

### 5. SUSCRIPCIONES (Subscriptions)
**Función:** Tracking de pagos recurrentes

**Campos:**
- Nombre *
- Costo (ej: "5€/mes")
- Plan (Free, Pro, etc)
- Día de renovación (1-31)
- URL
- Asociada a: [Empresa o Marca] *

**Organización:**
- Sección: Corporativas (asociadas a empresa)
- Sección: Por marca (asociadas a marca)

**Cálculos automáticos:**
- Costo mensual por marca
- Alertas de renovación (este mes)

---

### 6. CREDENCIALES (Credentials)
**Función:** Gestor de passwords

**Campos:**
- Servicio *
- Usuario/Email
- Password (mostrar/ocultar) *
- URL
- Categoría * (Social Media, Email, Pagos, Tech, Dominios, Otro)
- Asociada a: [Empresa o Marca]

**Organización:**
- Por categoría con contadores
- Click en categoría → muestra credenciales
- Botón "Copiar" para password

**Categorías predefinidas:**
- 📱 Social Media
- ✉️ Email
- 💳 Pagos
- 💻 Tech
- 🌐 Dominios
- 📦 Otro

---

### 7. DOCUMENTOS (Documents)
**Función:** Links a archivos en la nube

**Campos:**
- Nombre *
- Tipo (PDF, Word, Excel, Imagen, Otro)
- URL * (link a Drive/Dropbox/Notion/etc)
- Plataforma (Google Drive, Dropbox, Notion, OneDrive, Otro)
- Asociado a: [Empresa o Marca]

**Organización:**
- Documentos corporativos (asociados a empresa)
- Por marca (asociados a marca)
- Otros (sin asociación)

**Funcionalidades:**
- Botón "Abrir →" (abre en nueva pestaña)
- Botón "Eliminar"
- Iconos según tipo (📕 PDF, 📘 Word, 📗 Excel, 🖼 Imagen)

---

### 8. MEMORIA CONTABLE
**Función:** Diario de decisiones empresariales

**Campos:**
- Tipo * (Nota, Cambio Contable, Decisión)
- Título *
- Contenido *
- Fecha *
- Referencia (opcional)
- Tags (separados por comas)

**Visual:**
- Borde izquierdo coloreado según tipo:
  - 🟣 Morado: Decisión
  - 🟢 Verde: Cambio Contable
  - ⚪ Gris: Nota
- Ordenado por fecha descendente
- Badge con el tipo
- Tags mostrados como chips

**Ubicación:** Dentro del detalle de cada empresa

---

### 9. BUSCADOR GLOBAL
**Función:** Búsqueda instantánea en todo el sistema

**Busca en:**
- Empresas (nombre, CIF)
- Marcas (nombre, tipo)
- Tareas (descripción)
- Credenciales (servicio)
- Documentos (nombre)

**Comportamiento:**
- Mínimo 2 caracteres para buscar
- Resultados en tiempo real
- Click en resultado → navega a ese elemento
- Cierra al hacer click fuera

**Ubicación:** Header (siempre visible)

---

### 10. CONFIGURACIÓN Y PERFIL
**Función:** Personalizar el sistema

**Campos editables:**
- Nombre del centro * (ej: "FGD VII — Control Center")
- Subtítulo
- Tu nombre *
- Email
- Teléfono
- Ubicación

**Persistencia:** localStorage (se guarda en el navegador)

**Botón:** En header "⚙️ Mi perfil"

---

## 🎨 DISEÑO Y UX

### Paleta de colores
```css
Background: #000 (negro puro)
Cards: #0D0D0D
Borders: #1A1A1A, #1F1F1F, #252525
Text: #FFFFFF (blanco)
Labels: #888, #666
```

### Etiquetas de estado
- 🟢 Verde (#4ADE80): Activa, Cambio Contable
- 🟡 Amarillo (#FBBF24): Desarrollo
- 🟣 Morado (#A78BFA): Concepto, Decisión
- 🔴 Rojo (#F87171): Pausa

### Etiquetas personalizadas
- Sistema de hash para colores consistentes
- 8 colores disponibles (verde, amarillo, rojo, morado, azul, naranja, rosa, cyan)
- Misma etiqueta = mismo color siempre

### Responsividad
- Mobile-first
- Grids adaptativos (grid-2, grid-3)
- Header sticky con blur backdrop
- Modales centrados y scrollables

---

## 💾 PERSISTENCIA DE DATOS

### Versión HTML (actual)
**Estado:** Los datos se pierden al refrescar
**Solución rápida:** Agregar localStorage (5 minutos)

### Versión con localStorage
```javascript
// Guardar después de cada cambio
function saveData() {
  localStorage.setItem('controlCenterData', JSON.stringify(data));
}

// Cargar al inicio
function loadData() {
  const saved = localStorage.getItem('controlCenterData');
  if (saved) {
    Object.assign(data, JSON.parse(saved));
  }
}
```

### Versión con base de datos (Taskbook)
**Stack:** Next.js 15 + Prisma + PostgreSQL + NextAuth
**Ver:** COMO-INTEGRAR.md

---

## 🔐 SEGURIDAD

### Versión HTML
- ⚠️ Sin autenticación
- ⚠️ Datos en localStorage (visible en DevTools)
- ⚠️ Passwords en texto plano

### Versión con Taskbook
- ✅ NextAuth (login seguro)
- ✅ Datos en PostgreSQL
- ✅ Passwords hasheados
- ✅ User isolation (cada usuario ve solo sus datos)

---

## 📊 FUNCIONALIDADES IMPLEMENTADAS

### ✅ CRUD Completo
- [x] Crear empresas
- [x] Crear marcas
- [x] Crear tareas (+ editar, completar, eliminar)
- [x] Crear suscripciones
- [x] Crear credenciales
- [x] Crear documentos
- [x] Crear memoria contable (+ eliminar)

### ✅ Navegación
- [x] Dashboard
- [x] Vista Empresas → Detalle empresa
- [x] Vista Marcas → Detalle marca
- [x] Vista Tareas (organizadas)
- [x] Vista Suscripciones (organizadas)
- [x] Vista Credenciales (por categoría)
- [x] Vista Documentos (organizados)

### ✅ Búsqueda
- [x] Buscador global
- [x] Navegación directa a resultados

### ✅ Cálculos automáticos
- [x] Costo mensual por marca
- [x] Contadores de tareas
- [x] Alertas de renovación

### ✅ Personalización
- [x] Etiquetas personalizadas (empresas y marcas)
- [x] Configuración del centro
- [x] Datos personales

---

## ❌ PENDIENTE (Para próxima sesión)

### Crítico
- [ ] **Editar empresas** (solo se pueden crear)
- [ ] **Editar marcas** (solo se pueden crear)
- [ ] **Persistencia con localStorage** (5 min)

### Deseable
- [ ] Editar suscripciones
- [ ] Editar credenciales
- [ ] Editar documentos
- [ ] Editar memoria contable
- [ ] Filtros por etiquetas
- [ ] Ordenar listas
- [ ] Exportar a Excel/CSV
- [ ] Upload de logos (empresas/marcas)
- [ ] Vista Dominios separada

---

## 🚀 CÓMO USARLO

### OPCIÓN 1: HTML Standalone (AHORA)
```bash
1. Descarga control-center-final.html
2. Abre con Chrome/Firefox
3. Funciona ✅ (pero sin persistencia)
```

### OPCIÓN 2: Con localStorage (Próxima sesión - 5 min)
```bash
1. Agregar funciones saveData() y loadData()
2. Llamar saveData() después de cada cambio
3. Los datos persisten ✅
```

### OPCIÓN 3: Integrar a Taskbook (2-3 horas)
```bash
1. Copiar schema → npx prisma migrate dev
2. Crear /app/control-center/
3. Convertir HTML → React components
4. Crear API routes
5. Listo: login seguro + multi-dispositivo ✅
```

Ver: **COMO-INTEGRAR.md**

---

## 📁 ARCHIVOS ENTREGADOS

1. **control-center-final.html** (2700 líneas)
   - Sistema completo funcionando
   - Datos de ejemplo cargados
   - Listo para usar

2. **schema-completo.prisma**
   - Modelos de base de datos
   - Relaciones definidas
   - Listo para migrar

3. **COMO-INTEGRAR.md**
   - Pasos para integrar a Taskbook
   - Ejemplos de código
   - Stack tecnológico

4. **ESPECIFICACIONES-COMPLETAS.md** (este archivo)
   - Documentación completa del sistema
   - Todos los módulos explicados
   - Roadmap de mejoras

---

## 🎯 PRÓXIMOS PASOS RECOMENDADOS

### Sesión próxima (1 hora)
1. ✅ Agregar localStorage (5 min)
2. ✅ Implementar edición de empresas (15 min)
3. ✅ Implementar edición de marcas (15 min)
4. ✅ Probar todo (10 min)
5. ✅ Exportar datos de ejemplo (5 min)

### Después (cuando tengas tiempo)
1. Integrar a Taskbook con Prisma + NextAuth
2. Subir a Vercel
3. Compartir con tu equipo
4. Migrar todos tus datos reales

---

## 💡 CASOS DE USO REALES

### Para ti (Fiorella)
```
EMPRESA: Rico.Vidarte SL
├── MARCAS:
│   ├── Difortuna Studio (Diseño)
│   ├── Etiketen (Packaging)
│   ├── Fliia (SaaS - 29€/mes)
│   ├── NUMA369 (App numerología)
│   ├── Porta (Uruguay)
│   └── 7 más...
├── MEMORIA CONTABLE:
│   ├── Actualizar escrituras
│   ├── Aportación capital 3000€
│   └── Gastos nave
└── TAREAS:
    ├── Reunión cliente Fliia
    ├── Revisar facturas
    └── Deploy beta
```

### Para un holding más grande
```
EMPRESAS:
├── Holding SpA (Chile)
├── Operations LLC (USA)  
├── Services Ltd (UK)
└── Tech GmbH (Alemania)

Cada una con:
- Múltiples marcas
- Cuentas bancarias en monedas locales
- Memoria contable con decisiones estratégicas
- Documentos legales en Drive
```

---

## 🔧 STACK TECNOLÓGICO

### Versión actual (HTML)
- HTML5 puro
- CSS3 (Flexbox, Grid)
- JavaScript vanilla
- localStorage (próximamente)

### Versión Taskbook (recomendada)
- **Frontend:** Next.js 15, React, TypeScript
- **Styling:** Tailwind CSS 4
- **Backend:** Next.js API Routes
- **Database:** Prisma + PostgreSQL (Vercel)
- **Auth:** NextAuth (login seguro)
- **Deploy:** Vercel
- **Tiempo:** 2-3 horas de integración

---

## 📞 SOPORTE

¿Dudas? Lee:
1. **COMO-INTEGRAR.md** - Para integrar a Taskbook
2. **Este archivo** - Para entender el sistema
3. Abre el HTML y prueba todo

---

## ✅ CHECKLIST DE IMPLEMENTACIÓN

```
[ ] Descargar los 3 archivos
[ ] Abrir control-center-final.html y probar
[ ] Crear empresas, marcas, tareas de prueba
[ ] Probar buscador global
[ ] Configurar tu perfil
[ ] Siguiente sesión: agregar persistencia
[ ] Después: integrar a Taskbook
[ ] ¡Listo para producción! 🚀
```

---

**Creado con ❤️ para Fiorella Giselle Difortuna**
**FGD VII — Control Center v1.0**
**Enero 2026**
