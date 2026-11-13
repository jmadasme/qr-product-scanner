# QR Product Scanner — Datasheet

## Especificaciones técnicas

| Característica | Detalle |
|---|---|
| **Tipo** | Aplicación web auto-contenida |
| **Formato** | HTML + CSS + JavaScript (archivo único) |
| **Versión** | 2.0.0 (web) |
| **Librería QR** | jsQR vía CDN |
| **API Cámara** | navigator.mediaDevices.getUserMedia |
| **Tipografía** | Inter (Google Fonts) |
| **Navegadores** | Chrome 80+, Edge 80+, Firefox 75+, Safari 13+ |
| **Tema** | Claro minimalista |
| **Idioma** | Español |
| **Peso** | ~25 KB (sin imágenes) |

## Requisitos

- Navegador web moderno con soporte para:
  - `navigator.mediaDevices.getUserMedia`
  - JavaScript ES6+
  - CSS Grid / Flexbox
  - CSS Custom Properties
- Cámara web (integrada o externa)
- Conexión a internet (para carga inicial de jsQR desde CDN)
- HTTPS o localhost (requisito del navegador para cámara)

## Manual de usuario

### Elementos de la interfaz

1. **Header**: Muestra el título "QR Product Scanner" y el subtítulo "Escanea códigos QR de productos".
2. **Área central de escaneo**:
   - **Placeholder** (cámara apagada): Icono de cámara grande, texto indicativo y botón "📷 Escanear QR".
   - **Visor de cámara** (cámara activa): Feed en vivo con cuadrante superpuesto.
3. **Cuadrante de escaneo**: Recuadro con 4 esquinas tipo "L" animadas (efecto breathing) y línea de barrido horizontal.
4. **Botón principal**: Alterna entre "📷 Escanear QR" (activa cámara) y "⏹ Detener" (desactiva cámara).
5. **Panel de resultados**: Aparece al detectar un QR. Muestra código, descripción y valor del producto.
6. **Barra de estado**: Indicador del ciclo actual (esperando, escaneando, consultando, encontrado).

### Flujo de trabajo

1. **Abrir la aplicación**: Abre `index.html` en el navegador.
2. **Activar cámara**: Presiona "📷 Escanear QR". El navegador pedirá permiso para usar la cámara. Concede el permiso.
3. **Enfocar QR**: Coloca un código QR dentro del cuadrante central.
4. **Detección**: Al detectar un QR válido, el cuadrante parpadea en verde.
5. **Resultado**: El panel inferior se despliega mostrando los datos del producto.
6. **Nuevo escaneo**: La cámara sigue activa. Enfoca otro QR para repetir el proceso.
7. **Detener**: Presiona "⏹ Detener" para apagar la cámara.

### Códigos QR válidos

Formato: `PROD-XXXXX-YYY`

- `PROD` — Prefijo fijo
- `XXXXX` — 5 dígitos (00123, 00456, etc.)
- `YYY` — 3 caracteres alfanuméricos mayúsculas (A7B, C9D, etc.)

Ejemplo: `PROD-00123-A7B`

### Productos pre-cargados

| Código | Descripción | Valor |
|---|---|---|
| PROD-00123-A7B | Auriculares Bluetooth Pro | $59.99 |
| PROD-00456-C9D | Teclado Mecánico RGB | $89.99 |
| PROD-00789-E1F | Monitor 27" 4K | $349.99 |
| PROD-00999-G3H | Webcam HD 1080p | $45.50 |

### Solución de problemas

| Problema | Causa posible | Solución |
|---|---|---|
| "Permiso de cámara denegado" | El usuario bloqueó la cámara | Concede permiso en la barra de direcciones del navegador |
| "No se detectó cámara" | Sin cámara conectada | Conecta una cámara USB o activa la integrada |
| "Error al abrir la cámara" | Cámara ocupada por otra app | Cierra otras aplicaciones que usen la cámara |
| El QR no se detecta | Mala iluminación o enfoque | Mejora la iluminación, acerca el QR |
| "Producto no registrado" | Código QR inválido | Usa un QR con formato PROD-XXXXX-YYY |
| Página no carga | Sin conexión a internet | Conéctate a internet para la carga inicial |
| Cámara no funciona en iOS | Requiere HTTPS | Sirve la página con HTTPS o en localhost |

### Consejos para escaneo exitoso

- Buena iluminación: evita sombras sobre el QR
- Superficie plana: el QR debe estar lo más plano posible
- Distancia: 10–30 cm entre cámara y QR
- Sin reflejos: evita superficies brillantes
- QR limpio: sin rasgaduras ni manchas
- Enfoca bien: espera a que la cámara enfoque automáticamente

### Mantenimiento

Esta es una aplicación web sin estado. No requiere mantenimiento más allá de mantener el navegador actualizado. Para actualizar la aplicación, simplemente reemplaza el archivo `index.html` con la nueva versión.
