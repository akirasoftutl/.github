#!/usr/bin/env bash
# Crea los equipos de la organización que corresponden a los roles de Scrum.
# El tablero y las etiquetas ya se gestionan con los workflows de este repo.
#
# Uso (requiere GitHub CLI y ser owner de la organización):
#   gh auth login
#   gh auth refresh -s admin:org
#   ./scripts/crear-equipos.sh [organizacion]
set -euo pipefail

ORG="${1:-akirasoftutl}"

crear_equipo() {
  local nombre="$1" descripcion="$2"
  if gh api "orgs/$ORG/teams/$nombre" >/dev/null 2>&1; then
    echo "El equipo '$nombre' ya existe."
  else
    gh api -X POST "orgs/$ORG/teams" -f name="$nombre" -f description="$descripcion" -f privacy=closed >/dev/null
    echo "Equipo '$nombre' creado."
  fi
}

crear_equipo "product-owner" "Prioriza el backlog y acepta el trabajo terminado"
crear_equipo "scrum-master"  "Facilita las reuniones y ayuda a resolver bloqueos"
crear_equipo "desarrollo"    "Construye y prueba lo comprometido en cada sprint"

echo
echo "Agrega a cada integrante a su equipo en https://github.com/orgs/$ORG/teams"
