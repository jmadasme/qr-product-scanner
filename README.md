# QR Product Scanner · QR · Web

![Estado](https://img.shields.io/badge/estado-preservado-2A9D8F?style=flat-square)
![Versiones](https://img.shields.io/badge/versiones-1-457B9D?style=flat-square)
![Sección](https://img.shields.io/badge/sección-software-5B7C99?style=flat-square)
![Licencia](https://img.shields.io/badge/licencia-MIT-06141b?style=flat-square)

> Escáner de QR de productos que corre en el navegador, sin backend ni instalación.

Este repositorio reúne **1 versión** de QR Product Scanner en `versions/`.
Cada carpeta conserva el contenido original de su etapa, sin `.git`, dependencias
instaladas ni binarios pesados. La documentación de operación y de código está en
[`docs/`](docs/), y el sitio del proyecto en [`docs/index.html`](docs/index.html).

## Índice de versiones

| Versión | Qué aporta | Archivos |
|---|---|---:|
| [`QRProductScanner`](versions/QRProductScanner/) | Escáner web autocontenido; la versión de escritorio anterior quedó como antecedente. | 10 |

La versión de referencia de esta familia es **`QRProductScanner`**: es la que se usa
para el README base y para los documentos canónicos. Las demás se mantienen
completas para que se pueda reconstruir la evolución y comparar decisiones.

## Arranque rápido

```bash
git clone https://github.com/jmadasme/qr-product-scanner.git
cd qr-product-scanner/versions/QRProductScanner
python3 -m http.server 8080
# abrí http://localhost:8080
```

La cámara solo funciona en localhost o HTTPS. Abrir el HTML con file:// puede bloquear el permiso.

<!-- ficha -->
## Ficha de evaluación

**Madurez global: 3.7/5**

| Criterio | Nota | Evidencia |
|---|---:|---|
| Madurez | 2/5 | Demo autocontenida con catálogo simulado y sin persistencia; no hay pruebas ni integración con inventario. |
| Reproducibilidad | 4/5 | Un index.html y cuatro PNG se sirven con python3 -m http.server; la decodificación requiere conexión para cargar jsQR desde CDN. |
| Documentación | 4/5 | README, datasheet y guía técnica describen flujo, estados y extensión; la recomendación de abrir file:// convive con el requisito de HTTPS. |
| Honestidad de límites | 4/5 | Declara datos simulados, dependencia de CDN y permisos de cámara; no presenta el demo como producto terminado. |
| Valor demostrativo | 4/5 | Concentra cámara, decodificación, validación de formato, estados de interfaz y consulta en un solo archivo legible. |
| Facilidad de despliegue | 4/5 | Se publica como estático en GitHub Pages o cualquier hosting; no hay build, pero la cámara exige HTTPS. |

Demostración compacta de un flujo de escaneo real, con catálogo simulado y dependencias explícitas; útil como base, no como inventario en producción. El código prioriza la claridad sobre la escalabilidad.

## Lo que no funcionó

### QRProductScanner — Reescritura desde escritorio

La versión anterior en PyQt6 y OpenCV obligaba a instalar Python, Qt y OpenCV para leer un código, una carga mayor que el problema a resolver. Se reescribió como una página única que usa la cámara del navegador. El README conserva la versión de escritorio como antecedente, pero no incluye su código.

### QRProductScanner — Catálogo simulado

La aplicación publicada usa un objeto PRODUCTS con cuatro productos de ejemplo y una latencia aleatoria de 300 a 800 ms. No consulta un inventario ni persiste lecturas. El README lo declara como demo y deja preparada la función getProduct() para sustituirla por una API real.

### QRProductScanner — CDN y permiso de cámara

jsQR se carga desde jsDelivr con la etiqueta @latest, así que el escaneo depende de la red en la primera carga y de una versión que puede cambiar. La cámara exige HTTPS o localhost, y abrir el archivo con file:// puede bloquear el permiso.

## Preguntas típicas

**¿Necesita Internet?**

No para escanear; solo para cargar la página si está publicada.

**¿Funciona en iPhone?**

Sí, con un navegador moderno y permiso de cámara.

**¿Guarda los códigos?**

No hay backend ni almacenamiento.

**¿Por qué cambiaron de PyQt6?**

Para eliminar la instalación y facilitar el uso en terreno.

**¿Lee códigos de barras?**

Está orientado a QR; otros formatos dependen de la API del navegador.

<!-- /ficha -->

## Documentación

- [`docs/datasheet.md`](docs/datasheet.md) — instalación, operación y límites.
- [`docs/developer.md`](docs/developer.md) — arquitectura, módulos y extensión.
- [`docs/REFERENCES.md`](docs/REFERENCES.md) — estándares, librerías y fuentes.
- [`docs/index.html`](docs/index.html) — página del proyecto (GitHub Pages).

## El proyecto en detalle

### QR Product Scanner

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

### ✨ Características

- **Interfaz moderna y minimalista** — Tema claro, tipografía Inter, bordes sutiles, sin colores fluorescentes
- **Cámara nativa del navegador** — Actívala con un clic (API `getUserMedia`)
- **Cuadrante de escaneo animado** — 4 esquinas tipo L con efecto *breathing* y línea de barrido
- **Detección QR en tiempo real** — Mediante `jsQR`, 4 capturas por segundo
- **API simulada** — 4 productos de ejemplo con latencia aleatoria (300–800ms)
- **Feedback visual completo** — Flash verde al detectar, spinner de carga, panel deslizante
- **Responsive** — Funciona en desktop y móvil
- **Sin dependencias** — Solo necesitas un navegador moderno

---

### 🚀 Cómo usar

#### Opción 1: Abrir directamente (recomendado)

Abre el archivo `index.html` en cualquier navegador moderno (Chrome, Edge, Safari, Firefox):

```bash
# Desde la terminal
open index.html        # macOS
xdg-open index.html    # Linux
start index.html       # Windows
```

O simplemente haz doble clic en `index.html`.

#### Opción 2: Servir con Python (para probar desde otro dispositivo)

```bash
cd QRProductScanner
python3 -m http.server 8080
```

Luego abre `http://localhost:8080` en tu navegador.

#### Opción 3: Online

El proyecto está disponible en GitHub Pages (si está habilitado):
```
https://wanderc137.github.io/QRProductScanner/
```

---

### 📱 Cómo escanear

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

#### Códigos QR de prueba

En la carpeta `resources/` hay 4 códigos QR pre-generados:

| Código | Producto | Valor |
|---|---|---|
| `PROD-00123-A7B` | Auriculares Bluetooth Pro | $59.99 |
| `PROD-00456-C9D` | Teclado Mecánico RGB | $89.99 |
| `PROD-00789-E1F` | Monitor 27" 4K | $349.99 |
| `PROD-00999-G3H` | Webcam HD 1080p | $45.50 |

Ábrelos en tu celular o en otra pantalla para probar.

---

### 🏗️ Estructura del proyecto

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

### 🧰 Tecnologías

| Tecnología | Propósito |
|---|---|
| **HTML5** | Estructura semántica |
| **CSS3** | Diseño con variables, flexbox, animaciones |
| **JavaScript (ES6+)** | Lógica de la aplicación |
| [**jsQR**](https://github.com/cozmo/jsQR) | Decodificación de QR en el cliente |
| [**Inter**](https://rsms.me/inter/) | Tipografía limpia y moderna |
| **MediaDevices API** | Acceso a cámara desde el navegador |

---

### ⚠️ Advertencias

- **Requiere permisos de cámara** en el navegador
- **Requiere conexión a internet** para cargar jsQR desde CDN
- **HTTPS requerido** en algunos navegadores para acceder a la cámara (en localhost funciona sin HTTPS)
- Esta es una **versión demo** con datos simulados
- Los datos mostrados son de ejemplo, no reales

---

### 🔌 Próximos pasos (conectar a API real)

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

### 📄 Licencia

MIT © 2026

---

Licencia MIT © 2026 jmadasme. Las versiones se publican como material de
referencia; los nombres de hardware y marcas pertenecen a sus respectivos dueños.
