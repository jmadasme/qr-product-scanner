# Referencias · QR Product Scanner

Documentación externa que se usó para entender el hardware, los protocolos y las
libertades del proyecto. No es una bibliografía decorativa: cada enlace apunta a
la fuente que explica una decisión concreta.

## Fuentes técnicas

| Fuente | Para qué se consultó |
|---|---|
| [Barcode Detection API](https://developer.mozilla.org/en-US/docs/Web/API/Barcode_Detection_API) | Lectura de códigos en el navegador. |

## Versiones de este repositorio

`QRProductScanner`

Cada carpeta puede tener dependencias y versiones distintas. Cuando el código
depende de una versión específica, esa versión está declarada en el README o en
el archivo de configuración de la carpeta, no en este documento.

## Criterio de preservación

- El código y los documentos se copiaron desde la carpeta original de trabajo.
- Se excluyeron `.git`, dependencias instaladas, compilados, registros y bases
  de datos locales.
- Se redactaron tokens, claves privadas y contraseñas detectadas en texto.
- Las plantillas `.example`, `.sample` y los valores de demostración se
  conservan porque documentan la configuración esperada.

## Limitaciones conocidas

Una herramienta de escaneo que exige instalar Python, OpenCV y Qt para leer un código es más cara que el problema que resuelve.

La documentación de cada versión describe el alcance real. Si una función no
está implementada, se dice; si un hardware no fue probado, también.
