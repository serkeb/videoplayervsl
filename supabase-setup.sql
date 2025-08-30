-- Script de configuración para Supabase
-- Ejecutar estos comandos en el SQL Editor de Supabase

-- 1. Crear tabla de videos
CREATE TABLE IF NOT EXISTS videos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  tags TEXT,
  file_name VARCHAR(255) NOT NULL UNIQUE,
  file_size BIGINT NOT NULL,
  file_type VARCHAR(100) NOT NULL,
  video_url TEXT NOT NULL,
  duration INTEGER, -- duración en segundos
  thumbnail_url TEXT,
  views INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Crear índices para mejorar el rendimiento
CREATE INDEX IF NOT EXISTS idx_videos_created_at ON videos(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_videos_title ON videos(title);
CREATE INDEX IF NOT EXISTS idx_videos_file_name ON videos(file_name);

-- 3. Crear función para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 4. Crear trigger para updated_at
DROP TRIGGER IF EXISTS update_videos_updated_at ON videos;
CREATE TRIGGER update_videos_updated_at
    BEFORE UPDATE ON videos
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- 5. Configurar Row Level Security (RLS)
ALTER TABLE videos ENABLE ROW LEVEL SECURITY;

-- 6. Eliminar políticas existentes para evitar conflictos
DROP POLICY IF EXISTS "Allow all operations on videos" ON videos;

-- 7. Crear políticas de seguridad específicas para el rol 'anon'
-- Permitir SELECT para todos
CREATE POLICY "Enable read access for all users" ON videos
  FOR SELECT USING (TRUE);

-- Permitir INSERT para el rol 'anon'
CREATE POLICY "Enable insert for anon users" ON videos
  FOR INSERT WITH CHECK (TRUE);

-- Permitir UPDATE para el rol 'anon' (opcional, si se necesita)
CREATE POLICY "Enable update for anon users" ON videos
  FOR UPDATE USING (TRUE);

-- Permitir DELETE para el rol 'anon' (opcional, si se necesita)
CREATE POLICY "Enable delete for anon users" ON videos
  FOR DELETE USING (TRUE);

-- 8. Crear bucket de storage para videos (ejecutar en el dashboard de Storage)
-- INSERT INTO storage.buckets (id, name, public) VALUES ('videos', 'videos', true);

-- 9. Crear política de storage para el bucket de videos
-- INSERT INTO storage.policies (bucket_id, name, definition, check_definition, command)
-- VALUES (
--   'videos',
--   'Allow all operations on videos bucket',
--   'true',
--   'true',
--   'ALL'
-- );

-- Verificar que todo esté configurado correctamente
SELECT 
  table_name,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns 
WHERE table_name = 'videos'
ORDER BY ordinal_position;

