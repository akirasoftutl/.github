# 🏃 Guía Scrum — AkiraSoft UTL

Cómo trabajamos Scrum con **GitHub Issues + GitHub Projects** en todos los repositorios de la organización.

---

## 👥 Roles

| Rol | Equipo en GitHub | Etiqueta | Responsabilidades |
|---|---|---|---|
| **Product Owner** | `@akirasoftutl/product-owner` | `rol: product owner` | Crea Épicas e Historias, prioriza el Product Backlog, acepta o rechaza el trabajo en la Review. |
| **Scrum Master** | `@akirasoftutl/scrum-master` | `rol: scrum master` | Abre la issue de cada Sprint, facilita las ceremonias, elimina impedimentos (`estado: bloqueado`). |
| **Equipo de desarrollo** | `@akirasoftutl/desarrollo` | `rol: frontend`, `rol: backend`, `rol: base de datos`, `rol: diseño ui/ux`, `rol: qa`, `rol: devops`, `rol: documentación` | Estima, divide historias en tareas, construye y prueba el incremento. |

> **Asignar trabajo:** abre la issue → *Assignees* (la persona) → *Labels* (`rol: ...`) → *Projects* (Scrum Board, campo **Sprint**).

---

## 🗂️ Tipos de issue (plantillas)

Al pulsar **New issue** en cualquier repo aparecen estas plantillas:

| Plantilla | Quién la crea | Para qué |
|---|---|---|
| 🏔️ **Épica** | Product Owner | Funcionalidad grande; sus historias se vinculan como *sub-issues*. |
| 📖 **Historia de Usuario** | Product Owner | "Como… quiero… para…" + criterios de aceptación + Story Points. |
| 🛠️ **Tarea** | Equipo de desarrollo | Trabajo técnico concreto de una historia. |
| 🐞 **Bug** | Cualquiera | Error encontrado. |
| 🔬 **Spike** | Equipo de desarrollo | Investigación con tiempo limitado. |
| 🏃 **Sprint** | Scrum Master | Registro del Sprint: Planning, Dailies, Review y Retro. |

Jerarquía: **Épica → Historia de Usuario → Tareas** (usa *Create sub-issue* dentro de la issue padre).

---

## 🔄 Flujo de estados (To-Do)

```
Backlog → Listo → Por hacer → En progreso → En revisión → Hecho
                                   ↘ Bloqueado ↗
```

| Estado | Significado | Quién lo mueve |
|---|---|---|
| **Backlog** | Idea en el Product Backlog, sin refinar | PO |
| **Listo** | Cumple la *Definition of Ready* | PO + equipo en el refinamiento |
| **Por hacer** (To-Do) | Comprometida en el Sprint actual | Equipo en el Sprint Planning |
| **En progreso** | Alguien la está trabajando (¡asígnate!) | Desarrollador |
| **En revisión** | Hay un PR abierto o está en QA | Desarrollador |
| **Bloqueado** | Tiene un impedimento → avisar al SM | Cualquiera |
| **Hecho** | Cumple la *Definition of Done* (el PR con `Closes #N` la cierra sola) | Automático |

El estado se maneja con la columna **Status** del tablero *Scrum Board*. Las etiquetas `estado: ...` existen para quien prefiera filtrar desde la lista de issues.

---

## 📅 Ceremonias

| Ceremonia | Cuándo | Duración | Qué se hace en GitHub |
|---|---|---|---|
| **Sprint Planning** | Día 1 del Sprint | 2 h | SM abre la issue 🏃 Sprint. Se pasan historias de *Listo* a *Por hacer*, se asigna el campo **Sprint** y los responsables. |
| **Daily Scrum** | Cada día | 15 min | Cada quien revisa la vista *Por persona*. Bloqueos → `estado: bloqueado` y anotarlos en la issue del Sprint. |
| **Refinamiento** | A mitad del Sprint | 1 h | PO + equipo completan criterios de aceptación y Story Points (Planning Poker). |
| **Sprint Review** | Último día | 1 h | Demo del incremento. Llenar la sección *Sprint Review* (velocidad = puntos en *Hecho*). |
| **Retrospectiva** | Último día | 45 min | Llenar la sección *Retrospective* y cerrar la issue del Sprint. |

Sprints de **2 semanas**.

---

## ✅ Definition of Ready (DoR)

Una historia puede entrar a un Sprint si:
- [ ] Sigue el formato *Como / Quiero / Para*
- [ ] Tiene criterios de aceptación claros
- [ ] Está estimada en Story Points (≤ 8; si es 13 o más, dividirla)
- [ ] No tiene dependencias bloqueantes
- [ ] El equipo la entiende

## ✅ Definition of Done (DoD)

Una historia está terminada si:
- [ ] Cumple todos los criterios de aceptación
- [ ] El código está en la rama principal vía Pull Request revisado
- [ ] Tiene pruebas y pasan
- [ ] El Product Owner la aceptó en la Review
- [ ] Documentación actualizada (si aplica)

---

## ⚙️ Configuración (solo una vez, owner de la organización)

**1. Plantillas de issues y PR** — ya están activas: este repo `.github` las aplica a todos los repos de la organización que no tengan sus propias plantillas.

**2. Equipos, tablero y etiquetas** — desde tu computadora, con [GitHub CLI](https://cli.github.com/):

```bash
git clone https://github.com/akirasoftutl/.github.git && cd .github
gh auth login
gh auth refresh -s project,admin:org
./scripts/setup-scrum.sh
```

Esto crea los equipos (roles), el proyecto **Scrum Board** con campos *Story Points, Prioridad, Tipo, Rol*, y las etiquetas en todos los repos.

**3. Pasos manuales en el tablero** (la API aún no los permite):
1. Agregar un campo **Iteration** llamado `Sprint` (2 semanas).
2. Editar el campo **Status** con: `Backlog, Listo, Por hacer, En progreso, En revisión, Hecho`.
3. Crear las vistas:
   - **Tablero del Sprint** → Board, columnas por Status, filtro `sprint:@current`
   - **Product Backlog** → Table, filtro `status:Backlog,Listo`, ordenada por Prioridad
   - **Por persona** → Board agrupado por *Assignees*
   - **Roadmap** → Roadmap por Sprint
4. En **Workflows** activar: *Item closed → Done* y *Pull request merged → Done*. (Para meter las issues de todos los repos al tablero usa la sección **4. Automatización** de abajo; el *Auto-add to project* nativo solo cubre un repo por workflow.)
5. Agregar a cada integrante a su equipo en `https://github.com/orgs/akirasoftutl/teams`.

**4. Automatización para todos los repos** — crea un token en *Settings → Developer settings → Personal access tokens → Tokens (classic)* con los scopes `repo`, `project` y `read:org`, y guárdalo como secreto **`ORG_TOKEN`** en este repo (*Settings → Secrets and variables → Actions → New repository secret*). Con eso funcionan dos workflows:

| Workflow | Qué hace | Cuándo corre |
|---|---|---|
| *Agregar issues al tablero* | Mete al tablero (proyecto #1) toda issue abierta de cualquier repo de la organización que aún no esté. Cubre repos nuevos sin configurar nada. | Cada 15 min y a mano desde *Actions* |
| *Sincronizar etiquetas Scrum* | Crea/actualiza las etiquetas de `labels.json` en todos los repos. | Cada lunes, al cambiar `labels.json` y a mano |

> Si cambias de tablero, actualiza `PROJECT_NUMBER` en `.github/workflows/add-to-project.yml`.
