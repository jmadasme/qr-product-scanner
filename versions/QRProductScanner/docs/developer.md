# QR Product Scanner — Documentación para desarrolladores

## Arquitectura

La aplicación es un archivo HTML auto-contenido que integra:

```
index.html
├── HTML  → Estructura semántica (header, scanner, panel, footer)
├── CSS   → Estilos con variables, animaciones, responsive
└── JS    → Lógica: cámara, QR, API simulada, UI
    ├── Mock API (PRODUCTS)
    ├── Camera Manager (getUserMedia)
    ├── QR Scanner (jsQR loop)
    └── UI Controller (estados, animaciones)
```

No requiere servidor, build system ni dependencias adicionales. Se abre directamente en el navegador.

## Flujo de datos

```
Usuario → click "Escanear QR"
         → navigator.mediaDevices.getUserMedia()
         → stream → <video>
         → setInterval cada 250ms:
             → canvas.drawImage(video)
             → canvas.getImageData()
             → jsQR(imageData, width, height)
             → si QR válido (PROD-XXXXX-YYY):
                 → flash verde
                 → stopScanLoop()
                 → getProduct(code, callback)
                 → setTimeout 300-800ms:
                     → buscar en PRODUCTS
                     → si existe: showResult(data)
                     → si no: showError(msg)
                 → tras 2.5s: reset + startScanLoop()
```

## Módulos (JavaScript)

### 1. Mock API (`PRODUCTS` + `getProduct()`)

Objeto con 4 productos de prueba. La función `getProduct(code, callback)` simula latencia de red (300–800ms) y retorna el producto o `null`.

```javascript
const PRODUCTS = {
  'PROD-00123-A7B': { code, description, value, currency },
  // ...
};

function getProduct(code, onResult) {
  const delay = 300 + Math.random() * 500;
  setTimeout(() => onResult(PRODUCTS[code] || null), delay);
}
```

### 2. Camera Manager

Usa la API `MediaDevices` con `facingMode: 'environment'` para usar la cámara trasera en dispositivos móviles.

```javascript
stream = await navigator.mediaDevices.getUserMedia({
  video: { facingMode: 'environment', width: { ideal: 640 }, height: { ideal: 480 } },
  audio: false,
});
```

**Manejo de errores**:
- `NotAllowedError` / `PermissionDeniedError` → "Permiso de cámara denegado"
- `NotFoundError` → "No se detectó cámara"
- Otros → "Error al abrir la cámara"

### 3. QR Scanner Loop

Bucle con `setInterval` (250ms) que:
1. Dibuja el frame actual del video en un `<canvas>`
2. Extrae `ImageData` del canvas
3. Llama a `jsQR(imageData.data, width, height)`
4. Valida el formato del QR con regex: `/^PROD-\d{5}-[A-Z0-9]{3}$/`
5. Evita re-detección del mismo código (`lastCode`)
6. Activa el flash visual al detectar

### 4. UI Controller

Máquina de estados simple:

```
IDLE → SCANNING → PROCESSING → RESULT / ERROR → SCANNING → ...
                → IDLE (si el usuario detiene la cámara)
```

Funciones principales:
- `showPlaceholder()` / `showCameraView()` — alternar vistas
- `showLoading()` / `showResult(data)` / `showError(msg)` — panel de resultado
- `flashViewfinder()` — animación de detección
- `setStatus(text, cssClass)` — barra de estado
- `resetScanner()` — reinicia flag de procesamiento

## Animaciones CSS

| Animación | Elemento | Duración | Descripción |
|---|---|---|---|
| `breathe-*` | Esquinas (4) | 2.4s | Movimiento sinusoidal de las 4 esquinas |
| `sweep` | Línea horizontal | 2.4s | Barrido vertical dentro del viewfinder |
| `flash-green` | Viewfinder | 0.4s | Flash verde al detectar QR |
| `slideUp` | Panel resultado | 0.35s | Deslizamiento hacia arriba |
| `spin` | Spinner | 0.8s | Rotación del indicador de carga |

## Personalización

### Colores

Edita las variables CSS en `:root`:

```css
:root {
  --accent: #0071E3;        /* Color principal */
  --success: #30D158;       /* Color de éxito */
  --error: #FF453A;         /* Color de error */
  --text-primary: #1D1D1F;  /* Texto principal */
  --text-secondary: #86868B;/* Texto secundario */
}
```

### Productos mock

Edita el objeto `PRODUCTS` en el JavaScript:

```javascript
const PRODUCTS = {
  'PROD-00123-A7B': {
    code: 'PROD-00123-A7B',
    description: 'Auriculares Bluetooth Pro',
    value: 59.99,
    currency: '$',
  },
  // Añade más productos aquí
};
```

### Formato QR

Edita la expresión regular en el bucle de escaneo:

```javascript
const match = raw.match(/^PROD-\d{5}-[A-Z0-9]{3}$/);
// Cambia el patrón según necesites
```

### Velocidad de escaneo

Edita el intervalo en `startScanLoop()`:

```javascript
const scanInterval = 250; // ms entre capturas (menor = más rápido, mayor = menos CPU)
```

## Conexión a API real

Reemplaza `getProduct()` con una llamada `fetch`:

```javascript
async function getProduct(code, onResult) {
  try {
    const response = await fetch(`https://tu-api.com/products/${code}`);
    if (!response.ok) {
      onResult(null);
      return;
    }
    const data = await response.json();
    onResult(data);
  } catch (err) {
    console.error('Error consultando API:', err);
    onResult(null);
  }
}
```

## Despliegue

### Opción 1: Archivo local
Simplemente abre `index.html` en el navegador.

### Opción 2: Python HTTP Server
```bash
python3 -m http.server 8080
```

### Opción 3: GitHub Pages
```bash
git checkout -b gh-pages
git push origin gh-pages
```

### Opción 4: Servidor web estático
Sube `index.html` y la carpeta `resources/` a cualquier servidor web (Nginx, Apache, Netlify, Vercel).

## Notas técnicas

- El canvas usa `willReadFrequently: true` para optimizar la lectura de píxeles.
- `jsQR` se carga desde CDN. Para uso offline, descarga el archivo y cárgalo localmente.
- La cámara trasera se usa por defecto (`facingMode: 'environment'`). Cambia a `'user'` para la cámara frontal.
- El flash verde se logra con `box-shadow` animado en el viewfinder.
- La prevención de re-detección usa `lastCode` para evitar emitir el mismo QR repetidamente.
