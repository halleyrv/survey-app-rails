#!/bin/bash


# Ejecutar la precompilación de assets y construir la imagen
docker-compose run web rails assets:precompile
docker-compose build


# Detener los contenedores de Docker Compose
docker-compose down

# Iniciar los contenedores nuevamente
docker-compose up
