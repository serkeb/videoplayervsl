# 🚀 Guía de Despliegue - VideoStream Pro

Esta guía te ayudará a desplegar tu plataforma VideoStream Pro en producción.

## 📋 Requisitos Previos

- Cuenta de Supabase configurada
- Dominio propio (opcional pero recomendado)
- Cuenta en plataforma de hosting (Vercel, Netlify, etc.)

## 🔧 Configuración de Supabase

### 1. Crear Proyecto en Supabase
1. Ve a [supabase.com](https://supabase.com)
2. Crea una nueva organización y proyecto
3. Anota la URL y la clave anónima

### 2. Configurar Base de Datos
1. Ve a SQL Editor en tu dashboard de Supabase
2. Ejecuta el contenido completo del archivo `supabase-setup.sql`
3. Verifica que la tabla `videos` se haya creado correctamente

### 3. Configurar Storage
1. Ve a Storage en el dashboard
2. Crea un nuevo bucket llamado "videos"
3. Configúralo como público
4. Ve a Policies y crea una política que permita:
   - INSERT para usuarios autenticados
   - SELECT para todos
   - DELETE para usuarios autenticados

### 4. Configurar Políticas de Seguridad
```sql
-- Política para SELECT (lectura pública)
CREATE POLICY "Allow public read access on videos bucket" ON storage.objects
FOR SELECT USING (bucket_id = 'videos');

-- Política para INSERT (subida autenticada)
CREATE POLICY "Allow authenticated upload to videos bucket" ON storage.objects
FOR INSERT WITH CHECK (bucket_id = 'videos');

-- Política para DELETE (eliminación autenticada)
CREATE POLICY "Allow authenticated delete from videos bucket" ON storage.objects
FOR DELETE USING (bucket_id = 'videos');
```

## 🌐 Despliegue en Vercel

### 1. Preparar el Proyecto
```bash
# Instalar Vercel CLI
npm i -g vercel

# En el directorio del proyecto
vercel login
```

### 2. Configurar Variables de Entorno
```bash
vercel env add VITE_SUPABASE_URL
vercel env add VITE_SUPABASE_ANON_KEY
```

### 3. Desplegar
```bash
vercel --prod
```

### 4. Configurar Dominio (Opcional)
```bash
vercel domains add tu-dominio.com
```

## 🌐 Despliegue en Netlify

### 1. Conectar Repositorio
1. Ve a [netlify.com](https://netlify.com)
2. Conecta tu repositorio de Git
3. Configura el build:
   - Build command: `pnpm run build`
   - Publish directory: `dist`

### 2. Variables de Entorno
En Site settings > Environment variables:
- `VITE_SUPABASE_URL`: Tu URL de Supabase
- `VITE_SUPABASE_ANON_KEY`: Tu clave anónima

### 3. Configurar Redirects
Crear archivo `public/_redirects`:
```
/*    /index.html   200
```

## 🐳 Despliegue con Docker

### 1. Crear Dockerfile
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=0 /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### 2. Crear nginx.conf
```nginx
events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    server {
        listen 80;
        server_name localhost;
        root /usr/share/nginx/html;
        index index.html;

        location / {
            try_files $uri $uri/ /index.html;
        }
    }
}
```

### 3. Build y Deploy
```bash
docker build -t videostream-pro .
docker run -p 80:80 videostream-pro
```

## 🔒 Configuración de Seguridad

### 1. CORS en Supabase
En Authentication > Settings:
- Site URL: `https://tu-dominio.com`
- Additional URLs: Agregar dominios adicionales si es necesario

### 2. Rate Limiting
Configurar límites en Supabase:
- API Rate Limit: 100 requests/minute
- Storage Rate Limit: 10 uploads/minute

### 3. Validación de Archivos
El sistema ya incluye:
- Validación de tipo de archivo
- Límite de tamaño (100MB)
- Sanitización de nombres

## 📊 Monitoreo y Analytics

### 1. Supabase Analytics
- Ve a Reports en tu dashboard
- Monitorea uso de API y Storage
- Configura alertas de uso

### 2. Logs de Aplicación
```javascript
// Agregar en src/lib/supabase.js
const logEvent = (event, data) => {
  console.log(`[VideoStream] ${event}:`, data);
  // Opcional: enviar a servicio de analytics
};
```

### 3. Error Tracking
Considera integrar:
- Sentry para tracking de errores
- Google Analytics para métricas de uso
- Hotjar para análisis de comportamiento

## 🚀 Optimizaciones de Rendimiento

### 1. Compresión de Videos
```bash
# Instalar FFmpeg para optimización
npm install fluent-ffmpeg
```

### 2. CDN para Videos
- Configurar CloudFlare o AWS CloudFront
- Optimizar entrega de contenido global

### 3. Lazy Loading
El reproductor ya incluye:
- Preload="metadata"
- Carga diferida de componentes
- Optimización de imágenes

## 🔧 Mantenimiento

### 1. Backups Automáticos
Supabase incluye:
- Backups diarios automáticos
- Point-in-time recovery
- Exportación manual de datos

### 2. Actualizaciones
```bash
# Actualizar dependencias
pnpm update

# Verificar vulnerabilidades
pnpm audit

# Desplegar nueva versión
vercel --prod
```

### 3. Monitoreo de Salud
- Configurar health checks
- Monitorear uptime
- Alertas de rendimiento

## 📞 Soporte Post-Despliegue

### Problemas Comunes

**Error de CORS:**
- Verificar configuración de dominios en Supabase
- Comprobar variables de entorno

**Videos no cargan:**
- Verificar políticas de Storage
- Comprobar URLs públicas

**Lentitud en subidas:**
- Verificar límites de Supabase
- Considerar optimización de archivos

### Logs Útiles
```bash
# Ver logs de Vercel
vercel logs

# Ver logs de Netlify
netlify logs

# Logs de Supabase en dashboard
```

## 🎯 Próximos Pasos

1. **Configurar dominio personalizado**
2. **Implementar analytics avanzados**
3. **Agregar autenticación de usuarios**
4. **Configurar CDN para videos**
5. **Implementar compresión automática**

---

¡Tu plataforma VideoStream Pro está lista para conquistar el mundo de los VSLs! 🚀

