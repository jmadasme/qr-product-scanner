# QR Product Scanner

<p align="center">
  <img src="https://img.shields.io/badge/status-activo-30D158" alt="Status" />
  <img src="https://img.shields.io/badge/plataforma-web-0071E3" alt="Platform" />
  <img src="https://img.shields.io/badge/tecnología-HTML+CSS+JS-F5F5F7" alt="Tech" />
  <img src="https://img.shields.io/badge/licencia-MIT-86868B" alt="License" />
</p>

**Escáner profesional de códigos QR para consulta de productos** — ahora como aplicación web moderna.

> 🖥️ **Antes**: App de escritorio Python + PyQt6 + OpenCV  
> 🌐 **Ahora**: Web app auto-contenida (HTML + CSS + JS) — sin servidor, sin instalación

---

## ✨ Características

- **Interfaz moderna y minimalista** — Tema claro, tipografía Inter, bordes sutiles, sin colores fluorescentes
- **Cámara nativa del navegador** — Actívala con un clic (API `getUserMedia`)
- **Cuadrante de escaneo animado** — 4 esquinas tipo L con efecto *breathing* y línea de barrido
- **Detección QR en tiempo real** — Mediante `jsQR`, 4 capturas por segundo
- **API simulada** — 4 productos de ejemplo con latencia aleatoria (300–800ms)
- **Feedback visual completo** — Flash verde al detectar, spinner de carga, panel deslizante
- **Responsive** — Funciona en desktop y móvil
- **Sin dependencias** — Solo necesitas un navegador moderno

---

## 🚀 Cómo usar

### Opción 1: Abrir directamente (recomendado)

Abre el archivo `index.html` en cualquier navegador moderno (Chrome, Edge, Safari, Firefox):

```bash
# Desde la terminal
open index.html        # macOS
xdg-open index.html    # Linux
start index.html       # Windows
```

O simplemente haz doble clic en `index.html`.

### Opción 2: Servir con Python (para probar desde otro dispositivo)

```bash
cd QRProductScanner
python3 -m http.server 8080
```

Luego abre `http://localhost:8080` en tu navegador.

### Opción 3: Online

El proyecto está disponible en GitHub Pages (si está habilitado):
```
https://wanderc137.github.io/QRProductScanner/
```

---

## 📱 Cómo escanear

1. Abre la página → verás el **placeholder** con el botón "📷 Escanear QR"
2. Presiona el botón → el navegador pedirá permiso para usar la cámara
3. Acepta el permiso → el **visor** se activa con el cuadrante animado
4. **Enfoca un código QR** dentro del cuadrante
5. Escucharás/flash verde → el código se detecta automáticamente
6. La app consulta la API simulada y muestra:
   - Código del producto
   - Descripción
   - Valor
7. La cámara sigue activa para escanear otro producto

### Códigos QR de prueba

En la carpeta `resources/` hay 4 códigos QR pre-generados:

| Código | Producto | Valor |
|---|---|---|
| `PROD-00123-A7B` | Auriculares Bluetooth Pro | $59.99 |
| `PROD-00456-C9D` | Teclado Mecánico RGB | $89.99 |
| `PROD-00789-E1F` | Monitor 27" 4K | $349.99 |
| `PROD-00999-G3H` | Webcam HD 1080p | $45.50 |

Ábrelos en tu celular o en otra pantalla para probar.

---

## 🏗️ Estructura del proyecto

```
QRProductScanner/
├── index.html             ← Web app (todo en uno)
├── README.md              ← Este archivo
├── PLAN.md                ← Plan de desarrollo
├── AUDIT_REPORT.md        ← Reporte de auditoría
├── resources/
│   ├── qr_PROD-00123-A7B.png
│   ├── qr_PROD-00456-C9D.png
│   ├── qr_PROD-00789-E1F.png
│   └── qr_PROD-00999-G3H.png
└── docs/
    ├── datasheet.md       ← Documentación de usuario
    └── developer.md       ← Documentación técnica
```

---

## 🧰 Tecnologías

| Tecnología | Propósito |
|---|---|
| **HTML5** | Estructura semántica |
| **CSS3** | Diseño con variables, flexbox, animaciones |
| **JavaScript (ES6+)** | Lógica de la aplicación |
| [**jsQR**](https://github.com/cozmo/jsQR) | Decodificación de QR en el cliente |
| [**Inter**](https://rsms.me/inter/) | Tipografía limpia y moderna |
| **MediaDevices API** | Acceso a cámara desde el navegador |

---

## ⚠️ Advertencias

- **Requiere permisos de cámara** en el navegador
- **Requiere conexión a internet** para cargar jsQR desde CDN
- **HTTPS requerido** en algunos navegadores para acceder a la cámara (en localhost funciona sin HTTPS)
- Esta es una **versión demo** con datos simulados
- Los datos mostrados son de ejemplo, no reales

---

## 🔌 Próximos pasos (conectar a API real)

El código está preparado para conectarse a una API real. Solo necesitas reemplazar la función `getProduct()` en `index.html` con una llamada `fetch()` a tu endpoint:

```javascript
async function getProduct(code, onResult) {
  try {
    const res = await fetch(`/api/products/${code}`);
    const data = await res.json();
    onResult(data);
  } catch (err) {
    onResult(null);
  }
}
```

---

## 📄 Licencia

MIT © 2026
