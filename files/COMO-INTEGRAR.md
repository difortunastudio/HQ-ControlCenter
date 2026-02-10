# 🚀 CÓMO INTEGRAR CONTROL CENTER A TU TASKBOOK

## Stack Tecnológico (YA LO TIENES)
- **Next.js 15** + App Router
- **Prisma** + PostgreSQL (Vercel)
- **NextAuth** (autenticación)
- **TypeScript**
- **Tailwind CSS 4**

---

## PASOS RÁPIDOS

### 1. COPIAR SCHEMA A PRISMA

Abre `/prisma/schema.prisma` y agrega los modelos del archivo `schema-completo.prisma`

### 2. MIGRAR BASE DE DATOS

```bash
npx prisma migrate dev --name add-control-center
npx prisma generate
```

### 3. CREAR CARPETA EN TU APP

```
/app/control-center/
  ├── page.tsx          (componente principal)
  ├── components/
  │   ├── CompanyList.tsx
  │   ├── BrandList.tsx
  │   ├── TaskList.tsx
  │   └── modals/
  └── api/
      ├── companies/route.ts
      ├── brands/route.ts
      ├── tasks/route.ts
      ├── subscriptions/route.ts
      └── credentials/route.ts
```

### 4. COPIAR EL HTML A REACT

El archivo `control-center-final.html` tiene TODO el código. Solo necesitas:

**Convertir a React:**
```tsx
// app/control-center/page.tsx
'use client'

import { useState, useEffect } from 'react'
import { useSession } from 'next-auth/react'

export default function ControlCenter() {
  const { data: session } = useSession()
  const [companies, setCompanies] = useState([])
  const [brands, setBrands] = useState([])
  const [tasks, setTasks] = useState([])
  
  // Copiar las funciones del HTML aquí
  // Cambiar data.companies por companies
  // Cambiar data.brands por brands
  // etc...
}
```

### 5. CREAR API ROUTES

**Ejemplo: `/app/api/control-center/tasks/route.ts`**

```typescript
import { NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { prisma } from '@/lib/prisma'

export async function GET() {
  const session = await getServerSession()
  if (!session?.user?.email) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const tasks = await prisma.task.findMany({
    where: { userId: session.user.id },
    include: { brand: true, company: true }
  })

  return NextResponse.json(tasks)
}

export async function POST(request: Request) {
  const session = await getServerSession()
  const body = await request.json()

  const task = await prisma.task.create({
    data: {
      ...body,
      userId: session.user.id
    }
  })

  return NextResponse.json(task)
}
```

### 6. USAR EN TU APP

Ya tienes NextAuth configurado, solo agrega una nueva ruta:

```tsx
// app/layout.tsx o donde tengas tu nav
<Link href="/control-center">Control Center</Link>
```

---

## ALTERNATIVA MÁS RÁPIDA

Si quieres probarlo YA sin código:

1. **Sube el HTML a Vercel:**
   ```bash
   vercel deploy control-center-final.html
   ```

2. **Agrega localStorage para persistir:**
   - Los datos se guardan en el navegador
   - No necesitas base de datos aún

3. **Cuando funcione, migra a tu Taskbook**

---

## PROTEGER CON PASSWORD

Tu Taskbook ya tiene NextAuth. Solo envuelve la página:

```tsx
// app/control-center/page.tsx
import { redirect } from 'next/navigation'
import { getServerSession } from 'next-auth'

export default async function ControlCenter() {
  const session = await getServerSession()
  
  if (!session) {
    redirect('/login')
  }

  return <ControlCenterClient />
}
```

---

## RESUMEN

✅ Ya tienes el stack (Next.js + Prisma + Auth)
✅ Schema listo (schema-completo.prisma)
✅ UI funcionando (control-center-final.html)

Solo necesitas:
1. Copiar schema → migrar DB
2. Convertir HTML → React component
3. Crear API routes (5 archivos)
4. Usar session de NextAuth

**Tiempo estimado: 2-3 horas**

---

## NECESITAS AYUDA?

1. Copia el schema → migra
2. Crea la carpeta `/app/control-center`
3. Dame acceso al repo y lo termino yo 😉
