# AkiraSoft - UTL

Configuración compartida de la organización (se aplica a todos los repos que no tengan la suya).

| Archivo | Para qué |
|---|---|
| [`SCRUM.md`](SCRUM.md) | Guía de Scrum: roles, ceremonias, estados, DoR/DoD y **pasos de configuración** |
| [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE) | Plantillas: Épica, Historia de Usuario, Tarea, Bug, Spike, Sprint |
| [`.github/pull_request_template.md`](.github/pull_request_template.md) | Plantilla de Pull Request con la Definition of Done |
| [`labels.json`](labels.json) | Etiquetas de tipo, estado, prioridad, Story Points y rol |
| [`scripts/setup-scrum.sh`](scripts/setup-scrum.sh) | Crea equipos (roles), el tablero *Scrum Board* y las etiquetas |
| [`.github/workflows/add-to-project.yml`](.github/workflows/add-to-project.yml) | Agrega al tablero las issues abiertas de todos los repos cada 15 min (requiere secreto `AKIRASOFTUTL`) |
| [`.github/workflows/sync-labels.yml`](.github/workflows/sync-labels.yml) | Sincroniza las etiquetas en todos los repos (requiere secreto `AKIRASOFTUTL`) |
