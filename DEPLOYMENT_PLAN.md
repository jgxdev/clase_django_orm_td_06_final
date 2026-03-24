# 📚 Plan de Despliegue Django en Vercel

## ✅ Checklist Pre-Despliegue

- [ ] Actualizar `SECRET_KEY` a una clave segura
- [ ] Configurar `DEBUG = False` en producción
- [ ] Configurar `ALLOWED_HOSTS` correctamente
- [ ] Revisar base de datos (SQLite no es ideal para Vercel)
- [ ] Asegurar que `.gitignore` tenga `db.sqlite3`, `.env`, `*.pyc`, `__pycache__/`

## 🔧 Configuración de Variables de Entorno en Vercel

### Paso 1: Acceder al Dashboard de Vercel
1. Ve a https://vercel.com/dashboard
2. Selecciona tu proyecto
3. Ve a **Settings** → **Environment Variables**

### Paso 2: Agregar Variables Requeridas

| Variable | Ejemplo | Descripción |
|----------|---------|-------------|
| `DJANGO_SECRET_KEY` | `django-insecure-...` | Clave secreta única (generar una nueva) |
| `DJANGO_DEBUG` | `False` | Siempre `False` en producción |
| `ALLOWED_HOSTS` | `tudominio.vercel.app,tudominio.com` | Dominios permitidos separados por comas |

### Paso 3: Generar Nueva SECRET_KEY (Importante!)

```python
from django.core.management.utils import get_random_secret_key
print(get_random_secret_key())
```

Ejecuta esto localmente y copia la salida como `DJANGO_SECRET_KEY` en Vercel.

## 📦 Estructura de Archivos Agregados

```
proyecto/
├── requirements.txt          # Dependencias Python
├── vercel.json              # Configuración de Vercel
├── build.sh                 # Script de construcción
├── .env.example             # Plantilla de variables de entorno
├── config/
│   └── settings.py          # Actualizado para variables de entorno
├── manage.py
└── ...
```

## 🚀 Pasos de Despliegue

### 1. Preparar el Repositorio Local

```bash
# Agregar .gitignore si no existe
echo "db.sqlite3
.env
*.pyc
__pycache__/
*.sqlite3
.venv/
/staticfiles/
/media/
node_modules/
.vercel/
" >> .gitignore

# Hacer commit de los cambios
git add requirements.txt vercel.json build.sh .env.example config/settings.py
git commit -m "Configuración para despliegue en Vercel"
git push origin main
```

### 2. Conectar Vercel con GitHub

1. Ve a https://vercel.com/new
2. Selecciona **Import Git Repository**
3. Autoriza Vercel en GitHub y selecciona tu repositorio
4. Click en **Import**

### 3. Configurar Vercel

En el formulario de importación:
- **Project Name**: `clase-django-orm` (o tu nombre)
- **Root Directory**: `.` (raíz del proyecto)
- **Build Command**: `pip install -r requirements.txt && python manage.py collectstatic --noinput && python manage.py migrate --noinput`
- **Output Directory**: (dejar vacío)
- **Install Command**: (dejar vacío)

### 4. Agregar Variables de Entorno

Antes de hacer deploy:
1. Click en **Environment Variables**
2. Agregar cada variable de la tabla anterior
3. Seleccionar en qué ambiente aplica (Production, Preview, Development)

### 5. Completar el Deploy

Click en **Deploy**

## 📝 Comandos Útiles

### Probar localmente con Vercel CLI

```bash
# Instalar Vercel CLI globalmente (opcional)
npm install -g vercel

# Probar build localmente
vercel build

# Ejecutar localmente similar a producción
vercel dev
```

### Generar nueva SECRET_KEY

```bash
python manage.py shell
>>> from django.core.management.utils import get_random_secret_key
>>> print(get_random_secret_key())
```

## ⚠️ Consideraciones Importantes

### 1. **Base de Datos**
- **SQLite (Actual)**: No persiste entre deployments en Vercel (filesystem efímero)
- **Solución**: Migrar a PostgreSQL o MongoDB
  - Opción A: Railway.app, Supabase o Neon para PostgreSQL
  - Opción B: MongoDB Atlas

### 2. **Archivos Estáticos**
- WhiteNoise maneja archivos estáticos automáticamente
- Los archivos se comprimen y cachean

### 3. **Archivos de Usuario (Media)**
- No usar filesystem local
- Usar S3, Supabase Storage o similar

### 4. **Timeouts**
- Vercel tiene límites de tiempo (12 segundos para plan gratuito)
- Operaciones pesadas deben ser asincrónicas

## 🐛 Troubleshooting

### Error: `ModuleNotFoundError: No module named 'django'`
```bash
# En Vercel, revisar que requirements.txt existe y esté en el root
# Limpiar build: Click en el proyecto > Deployments > Redeploy
```

### Error: `DEBUG = True` en producción
```python
# En settings.py: se usa por defecto 'False' desde variables de entorno
```

### Error: `DisallowedHost`
```
# Agregar dominio a ALLOWED_HOSTS en Vercel environment
# Ej: tudominio.vercel.app,tudominio.com
```

### Error: Migraciones no se ejecutan
```bash
# Ver logs en Vercel:
# Deployments > Click en deployment > View Logs
```

## 📊 Monitoreo Post-Despliegue

1. **Logs**: Vercel Dashboard → Logs
2. **Health Check**: Visitar la URL y verificar funcionamiento
3. **Errores**: Usar Django Debug Toolbar o logs de Vercel

## 📚 Resources Útiles

- [Vercel Django Docs](https://vercel.com/guides/deploying-django-with-vercel)
- [Django Deployment Checklist](https://docs.djangoproject.com/en/6.0/howto/deployment/checklist/)
- [WhiteNoise Documentation](http://whitenoise.evans.io/)
- [Environment Variables (Vercel)](https://vercel.com/docs/concepts/projects/environment-variables)

---

**Última actualización**: Marzo 2026
**Django Version**: 6.0.3
**Python**: 3.8+
