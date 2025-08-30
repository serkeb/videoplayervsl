# VideoStream Pro - Plataforma Privada de Videos

Una plataforma completa para subir, gestionar e incrustar videos con tecnología psicológica avanzada para maximizar el engagement en landing pages y VSLs.

## 🚀 Características Principales

### 📤 Subida de Videos
- **Drag & Drop**: Interfaz intuitiva para subir videos
- **Almacenamiento Seguro**: Integración con Supabase Storage
- **Validación**: Soporte para MP4, MOV, AVI, WebM (máx. 100MB)
- **Metadatos**: Título, descripción y tags personalizables

### 🎮 Reproductor Avanzado
- **Autoplay Inteligente**: Loop automático de 3 segundos sin sonido
- **Overlay Interactivo**: Activación de sonido con un clic
- **Barra Psicológica**: Progreso que acelera al inicio y se ralentiza
- **Controles Mínimos**: Solo play/pause, sin distracciones
- **Responsive**: Adaptable a cualquier dispositivo

### 🔧 Gestión Completa
- **Panel de Control**: Vista de todos los videos subidos
- **Estadísticas**: Visualizaciones y métricas de engagement
- **Eliminación**: Gestión completa de archivos y metadatos
- **Búsqueda**: Filtros por título, fecha y tags

### 📋 Códigos de Incrustación
- **Iframe**: Código estándar para cualquier sitio web
- **HTML**: Página completa lista para usar
- **React**: Componente para aplicaciones React
- **Configuración**: Autoplay, controles y responsive

## 🛠️ Tecnologías Utilizadas

- **Frontend**: React 19 + Vite
- **UI**: Tailwind CSS + shadcn/ui
- **Base de Datos**: Supabase (PostgreSQL)
- **Almacenamiento**: Supabase Storage
- **Iconos**: Lucide React
- **Routing**: React Router DOM

## 📦 Instalación y Configuración

### 1. Clonar el Repositorio
\`\`\`bash
git clone <repository-url>
cd video-platform
\`\`\`

### 2. Instalar Dependencias
\`\`\`bash
pnpm install
\`\`\`

### 3. Configurar Variables de Entorno
Crear archivo \`.env\` en la raíz del proyecto:
\`\`\`env
VITE_SUPABASE_URL=tu_supabase_url
VITE_SUPABASE_ANON_KEY=tu_supabase_anon_key
\`\`\`

### 4. Configurar Supabase

#### 4.1 Crear Tablas
Ejecutar el script SQL en el SQL Editor de Supabase:
\`\`\`sql
-- Ver archivo: supabase-setup.sql
\`\`\`

#### 4.2 Configurar Storage
1. Ir a Storage en el dashboard de Supabase
2. Crear un bucket llamado "videos"
3. Configurar como público
4. Configurar políticas de acceso

### 5. Iniciar Desarrollo
\`\`\`bash
pnpm run dev
\`\`\`

## 🎯 Uso de la Plataforma

### Subir Videos
1. Ir a "Subir Video"
2. Arrastrar archivo o hacer clic para seleccionar
3. Completar título (requerido)
4. Agregar descripción y tags (opcional)
5. Hacer clic en "Subir Video"

### Gestionar Videos
1. Ir a "Mis Videos"
2. Ver todos los videos subidos
3. Acciones disponibles:
   - Ver video
   - Generar código de incrustación
   - Copiar código rápido
   - Eliminar video

### Generar Códigos de Incrustación
1. Ir a "Incrustar" o desde "Mis Videos"
2. Seleccionar video
3. Configurar opciones:
   - Dimensiones (ancho/alto)
   - Autoplay (sí/no)
   - Controles (sí/no)
   - Responsive (sí/no)
4. Copiar código en formato deseado:
   - Iframe
   - HTML completo
   - Componente React

## 🧠 Tecnología Psicológica

### Barra de Progreso Psicológica
La barra de progreso implementa un algoritmo psicológico que:

1. **Primeros 40%**: Avanza 1.5x más rápido de lo normal
2. **Después del 40%**: Se ralentiza progresivamente
3. **Efecto**: Crea sensación de proximidad al final, luego "estira" el tiempo

### Autoplay Inteligente
- **Loop de 3 segundos**: Mantiene engagement sin molestar
- **Sin sonido inicial**: Respeta políticas de navegadores
- **Activación manual**: Overlay atractivo para activar sonido
- **Transición suave**: Del loop al video completo

## 📱 Responsive Design

La plataforma está optimizada para:
- **Desktop**: Experiencia completa con todas las funcionalidades
- **Tablet**: Interfaz adaptada para pantallas medianas
- **Mobile**: Navegación táctil y controles optimizados

## 🔒 Seguridad

- **Row Level Security**: Políticas de acceso en Supabase
- **Validación de archivos**: Solo formatos de video permitidos
- **Límites de tamaño**: Máximo 100MB por archivo
- **URLs seguras**: Acceso controlado a través de Supabase

## 🚀 Despliegue

### Desarrollo
\`\`\`bash
pnpm run dev --host
\`\`\`

### Producción
\`\`\`bash
pnpm run build
pnpm run preview
\`\`\`

### Plataformas Recomendadas
- **Vercel**: Despliegue automático desde Git
- **Netlify**: Integración continua
- **Supabase**: Hosting nativo

## 📊 Estructura del Proyecto

\`\`\`
video-platform/
├── public/                 # Archivos estáticos
├── src/
│   ├── components/        # Componentes reutilizables
│   │   ├── ui/           # Componentes de UI (shadcn)
│   │   └── VideoPlayer.jsx # Reproductor principal
│   ├── pages/            # Páginas de la aplicación
│   │   ├── HomePage.jsx  # Página de inicio
│   │   ├── UploadPage.jsx # Subida de videos
│   │   ├── VideosPage.jsx # Gestión de videos
│   │   └── EmbedPage.jsx # Códigos de incrustación
│   ├── lib/              # Utilidades y configuración
│   │   └── supabase.js   # Cliente y servicios de Supabase
│   ├── App.jsx           # Componente principal
│   └── main.jsx          # Punto de entrada
├── supabase-setup.sql    # Script de configuración de BD
├── .env                  # Variables de entorno
└── README.md            # Documentación
\`\`\`

## 🎬 Ejemplo de Uso como VSL

### Código de Incrustación Básico
\`\`\`html
<iframe 
  src="https://tu-dominio.com/embed/video-id" 
  width="800" 
  height="450" 
  frameborder="0" 
  allowfullscreen>
</iframe>
\`\`\`

### Código Responsive
\`\`\`html
<div style="position: relative; padding-bottom: 56.25%; height: 0;">
  <iframe 
    src="https://tu-dominio.com/embed/video-id" 
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
    frameborder="0" 
    allowfullscreen>
  </iframe>
</div>
\`\`\`

## 🐛 Solución de Problemas

### Error de Conexión a Supabase
1. Verificar variables de entorno
2. Comprobar configuración de Supabase
3. Revisar políticas de seguridad

### Videos no se Suben
1. Verificar formato de archivo
2. Comprobar tamaño (máx. 100MB)
3. Revisar configuración del bucket

### Reproductor no Funciona
1. Verificar URL del video
2. Comprobar políticas CORS
3. Revisar configuración de autoplay del navegador

## 📞 Soporte

Para soporte técnico o consultas:
- Revisar la documentación
- Verificar configuración de Supabase
- Comprobar logs del navegador

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver archivo LICENSE para más detalles.

---

**VideoStream Pro** - La plataforma definitiva para videos con tecnología psicológica avanzada.

