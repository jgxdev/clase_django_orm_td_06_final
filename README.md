# 🎓 Clase Django ORM - TD 06

Proyecto Django para gestión de clientes con ORM.

## 🚀 Despliegue en Vercel

Consulta [DEPLOYMENT_PLAN.md](DEPLOYMENT_PLAN.md) para el plan detallado.

### Pasos Rápidos

1. **Generar SECRET_KEY segura:**
   ```bash
   python manage.py shell
   >>> from django.core.management.utils import get_random_secret_key
   >>> print(get_random_secret_key())
   ```

2. **Configurar Variables de Entorno en Vercel:**
   - `DJANGO_SECRET_KEY`: Tu clave generada
   - `DJANGO_DEBUG`: `False`
   - `ALLOWED_HOSTS`: `tudominio.vercel.app,tudominio.com`

3. **Push a GitHub:**
   ```bash
   git add .
   git commit -m "Configuración Vercel"
   git push origin main
   ```

4. **Desplegar:**
   - Ve a https://vercel.com/import
   - Conecta tu repositorio
   - Vercel detectará automáticamente la configuración
   - Agrega las variables de entorno
   - Click en Deploy

## 📝 Desarrollo Local

```bash
# Instalar dependencias
pip install -r requirements.txt

# Migraciones
python manage.py migrate

# Crear superuser
python manage.py createsuperuser

# Ejecutar servidor
python manage.py runserver
```

## ⚠️ Importante

- **Base de Datos**: SQLite no persiste en Vercel. Migrar a PostgreSQL/MongoDB es recomendado.
- **Archivos Estáticos**: WhiteNoise maneja esto automáticamente.
- **SECRET_KEY**: Cambiar en producción por una clave segura.
