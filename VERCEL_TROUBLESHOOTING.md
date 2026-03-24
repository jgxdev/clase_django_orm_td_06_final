# 🔧 Solución del Error de Vercel/uv

## Error Específico

```
Using uv at "/usr/local/bin/uv"
No Python manifest found; creating an empty pyproject.toml and uv.lock...
Error: No django entrypoint found.
```

## ✅ Solución Aplicada

Hemos agregado los siguientes archivos para resolver esto:

### 1. **`wsgi.py` (en la raíz)**
```python
from config.wsgi import application
```

Vercel busca el WSGI entrypoint en ubicaciones específicas. Colocar `wsgi.py` en la raíz lo hace visible inmediatamente.

### 2. **`pyproject.toml`**
Define las dependencias y es compatible con `uv` (el gestor de paquetes que usa Vercel).

### 3. **`vercel.json`**
Configuración explícita que apunta al `wsgi.py` en la raíz.

## 🚀 Próximos Pasos

### Opción A: Deploy Limpio (Recomendado)
1. Push los cambios a GitHub:
```bash
git add wsgi.py pyproject.toml vercel.json .gitignore README.md
git commit -m "Fix: Agregar wsgi.py y pyproject.toml para Vercel"
git push origin main
```

2. En Vercel Dashboard:
   - Ve a tu proyecto
   - Click en **Deployments**
   - Click en los 3 puntos → **Redeploy** (o elimina el deployment anterior)
   - Espera a que rebuildee

### Opción B: Force Rebuild
Si aún falla, fuerza un rebuild:
```bash
# En tu terminal local
vercel redeploy
```

## ✅ Validar que Funcionó

1. Vercel logs deben mostrar:
   - ✅ `Installing dependencies...`
   - ✅ `Collecting static files...`
   - ✅ `Running migrations...`
   - ✅ `Build completed successfully!`

2. La URL de Vercel debe responder con tu app Django

3. Si ves `DisallowedHost`, agrega el dominio a `ALLOWED_HOSTS` variable de entorno

## 📋 Checklist Pre-Deploy

- [ ] `wsgi.py` existe en la raíz y contiene `from config.wsgi import application`
- [ ] `pyproject.toml` existe con las dependencias
- [ ] `requirements.txt` existe (como respaldo)
- [ ] `vercel.json` apunta a `wsgi.py` en la raíz
- [ ] `.env.example` documenta las variables necesarias
- [ ] `.gitignore` excluye `.env`, `db.sqlite3`, `__pycache__/`, etc.
- [ ] Variables de entorno están configuradas en Vercel Dashboard

## 🆘 Si Aún no Funciona

### Verificar Logs Detallados
```bash
# Si tienes Vercel CLI instalado
vercel logs
```

O en Vercel Dashboard:
- Deployments → Click en failed deployment → View Logs

### Errores Comunes

**Error: `ModuleNotFoundError: No module named 'django'`**
- Verifica que `requirements.txt` o `pyproject.toml` existan
- Limpia cache: Settings → Git → Disconnect y reconecta

**Error: `DisallowedHost`**
- Agrega tu dominio a `ALLOWED_HOSTS` variable en Vercel

**Error: `ImportError in config.wsgi`**
- Verifica que `config/wsgi.py` existe y es válido
- Que `config/settings.py` no tiene imports incorrectos

## 📚 Archivos Modificados/Creados

| Archivo | Propósito |
|---------|-----------|
| `wsgi.py` | Entrypoint WSGI que Vercel detecta automáticamente |
| `pyproject.toml` | Manifesto Python compatibility con uv |
| `vercel.json` | Configuración explícita de build routes |
| `requirements.txt` | Dependencias (respaldo) |
| `.gitignore` | Excluir archivos no deseados |
| `config/settings.py` | Soportar variables de entorno |
| `README.md` | Documentación principal |

---

Si el problema persiste, verifica que:
1. El repositorio está actualizado en GitHub
2. Vercel está conectado al branch correcto (`main`)
3. Limpiar cache del browser (Ctrl+Shift+Delete)
4. Revisar Vercel logs en tiempo real

**Última actualización**: Marzo 2026
