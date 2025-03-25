#!/bin/bash

# Nombre de la imagen
IMAGE_NAME=cuda-project

# Crear carpetas locales si no existen
mkdir -p data
mkdir -p output

# Ejecutar el contenedor
docker run --rm -it --gpus all \
-v $(pwd)/data:/workspace/data \
-v $(pwd)/output:/workspace/output \
${IMAGE_NAME}
echo "Ejecutando procesamiento batch de imágenes..."

./batch_processor

echo "Resultados guardados en la carpeta