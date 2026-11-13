#!/bin/bash
# QR Product Scanner — Web App
# Abre index.html en el navegador por defecto, o sirve via HTTP
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
HTML="$DIR/index.html"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  QR Product Scanner — Web App"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if command -v xdg-open &>/dev/null; then
    xdg-open "$HTML"
elif command -v open &>/dev/null; then
    open "$HTML"
elif command -v start &>/dev/null; then
    start "$HTML"
else
    echo "Abriendo con Python HTTP server en http://localhost:8080"
    python3 -m http.server -d "$DIR" 8080
fi
