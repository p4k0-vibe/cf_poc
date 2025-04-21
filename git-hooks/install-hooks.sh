#!/bin/bash

# Colores para las salidas
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Obtener el directorio del proyecto
REPO_ROOT=$(git rev-parse --show-toplevel)

echo -e "${YELLOW}Instalando git hooks en ${REPO_ROOT}/.git/hooks...${NC}"

# Verificar si el directorio .git/hooks existe
if [ ! -d "${REPO_ROOT}/.git/hooks" ]; then
  echo -e "${RED}Error: El directorio .git/hooks no existe. ¿Estás en un repositorio git?${NC}"
  exit 1
fi

# Copiar el hook de pre-commit
cp "${REPO_ROOT}/git-hooks/pre-commit" "${REPO_ROOT}/.git/hooks/pre-commit"

# Verificar si la copia fue exitosa
if [ $? -ne 0 ]; then
  echo -e "${RED}Error: No se pudo copiar el hook de pre-commit.${NC}"
  exit 1
fi

# Hacer el hook ejecutable
chmod +x "${REPO_ROOT}/.git/hooks/pre-commit"

# Verificar si el chmod fue exitoso
if [ $? -ne 0 ]; then
  echo -e "${RED}Error: No se pudo hacer el hook ejecutable.${NC}"
  exit 1
fi

echo -e "${GREEN}✓ Git hooks instalados correctamente.${NC}"
echo -e "${YELLOW}Ahora terraform validate se ejecutará automáticamente antes de cada commit.${NC}"

exit 0 