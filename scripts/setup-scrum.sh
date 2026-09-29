#!/usr/bin/env bash
# Configura Scrum en la organización: equipos (roles), tablero de GitHub Projects y etiquetas.
#
# Uso (requiere GitHub CLI con permisos de owner de la organización):
#   gh auth login
#   gh auth refresh -s project,admin:org
#   ./scripts/setup-scrum.sh [organizacion]
set -euo pipefail

ORG="${1:-akirasoftutl}"
PROJECT_TITLE="Scrum Board"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Organización: $ORG"

# --- 1. Equipos = roles de Scrum -----------------------------------------
create_team() {
  local name="$1" desc="$2"
  if gh api "orgs/$ORG/teams/$name" >/dev/null 2>&1; then
    echo "    equipo '$name' ya existe"
  else
    gh api -X POST "orgs/$ORG/teams" -f name="$name" -f description="$desc" -f privacy=closed >/dev/null
    echo "    equipo '$name' creado"
  fi
}

echo "==> Creando equipos (roles)"
create_team "product-owner" "Product Owner: gestiona y prioriza el Product Backlog"
create_team "scrum-master"  "Scrum Master: facilita las ceremonias y elimina impedimentos"
create_team "desarrollo"    "Equipo de desarrollo: construye el incremento de cada Sprint"

# --- 2. Tablero de GitHub Projects ------------------------------------------
echo "==> Creando proyecto '$PROJECT_TITLE'"
PROJECT_NUMBER=$(gh project list --owner "$ORG" --format json \
  --jq ".projects[] | select(.title == \"$PROJECT_TITLE\") | .number" | head -n1)

if [ -z "$PROJECT_NUMBER" ]; then
  PROJECT_NUMBER=$(gh project create --owner "$ORG" --title "$PROJECT_TITLE" --format json --jq '.number')
  echo "    proyecto #$PROJECT_NUMBER creado"

  gh project field-create "$PROJECT_NUMBER" --owner "$ORG" --name "Story Points" --data-type NUMBER >/dev/null
  gh project field-create "$PROJECT_NUMBER" --owner "$ORG" --name "Prioridad" --data-type SINGLE_SELECT \
    --single-select-options "🔴 Alta,🟠 Media,🟢 Baja" >/dev/null
  gh project field-create "$PROJECT_NUMBER" --owner "$ORG" --name "Tipo" --data-type SINGLE_SELECT \
    --single-select-options "Épica,Historia,Tarea,Bug,Spike" >/dev/null
  gh project field-create "$PROJECT_NUMBER" --owner "$ORG" --name "Rol" --data-type SINGLE_SELECT \
    --single-select-options "Product Owner,Scrum Master,Frontend,Backend,Base de datos,Diseño UI/UX,QA,DevOps,Documentación" >/dev/null
  echo "    campos Story Points, Prioridad, Tipo y Rol creados"
else
  echo "    proyecto '$PROJECT_TITLE' ya existe (#$PROJECT_NUMBER)"
fi

# --- 3. Etiquetas en todos los repos ----------------------------------------
echo "==> Sincronizando etiquetas en todos los repositorios"
for repo in $(gh repo list "$ORG" --limit 500 --no-archived --json name --jq '.[].name'); do
  echo "    $repo"
  jq -c '.[]' "$SCRIPT_DIR/../labels.json" | while read -r label; do
    gh label create "$(jq -r .name <<<"$label")" --repo "$ORG/$repo" \
      --color "$(jq -r .color <<<"$label")" --description "$(jq -r .description <<<"$label")" \
      --force >/dev/null || echo "      (no se pudo crear $(jq -r .name <<<"$label"))"
  done
done

cat <<EOF

✅ Listo. Pasos manuales que la API aún no permite (ver SCRUM.md → Configuración):
  1. En el proyecto: https://github.com/orgs/$ORG/projects/$PROJECT_NUMBER
     - Agrega un campo de tipo "Iteration" llamado "Sprint" (duración 2 semanas).
     - Edita el campo "Status" con: Backlog, Listo, Por hacer, En progreso, En revisión, Hecho.
     - Crea las vistas: "Tablero del Sprint" (Board por Status, filtro sprint:@current),
       "Product Backlog" (Table ordenada por Prioridad) y "Por persona" (Board agrupado por Assignees).
     - En Workflows activa "Auto-add to project" para los repos de la organización.
  2. Agrega a cada integrante a su equipo: https://github.com/orgs/$ORG/teams
EOF
