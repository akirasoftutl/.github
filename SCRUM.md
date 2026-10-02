# Guía de trabajo

Cómo organizamos el trabajo en AkiraSoft UTL usando GitHub Issues y el [tablero del equipo](https://github.com/orgs/akirasoftutl/projects/1). Aplica a todos los repositorios de la organización.

## En cinco pasos

1. **Registra el trabajo.** En el repo que corresponda, ve a *Issues > New issue* y elige una plantilla.
2. **La issue llega sola al tablero**, en la columna *Backlog*.
3. **El Product Owner la prioriza** y, cuando está clara y estimada, la pasa a *Ready*.
4. **Quien la toma se asigna** (*Assignees*) y la mueve a *In progress*. Cuando abre el pull request, la pasa a *In review*.
5. **Al fusionar el pull request se cierra sola** y pasa a *Done*, siempre que el PR diga `Closes #número`.

## Qué plantilla usar

| Plantilla | Cuándo usarla | Quién la crea normalmente |
|---|---|---|
| Historia de usuario | Una funcionalidad nueva desde el punto de vista del usuario. Es la más común. | Product Owner |
| Tarea | Trabajo técnico concreto, casi siempre parte de una historia. | Equipo de desarrollo |
| Reporte de error | Algo no funciona como debería. | Cualquiera |
| Épica | Un objetivo grande que agrupa varias historias. | Product Owner |
| Registro de sprint | Una por sprint, para dejar constancia del objetivo, la revisión y la retrospectiva. | Scrum Master |

Para relacionar issues usa **Create sub-issue** dentro de la issue padre: épica > historias > tareas. El tablero muestra el avance de cada una.

## El tablero

Cada tarjeta es una issue. Las columnas indican en qué punto está:

| Columna | Significa |
|---|---|
| Backlog | Registrada, todavía sin priorizar o sin detalle suficiente. |
| Ready | Clara y estimada. Se puede empezar en cualquier momento. |
| In progress | Alguien la está trabajando. Debe tener persona asignada. |
| In review | Hay un pull request abierto o está en pruebas. |
| Done | Terminada. |

Además de la columna, cada tarjeta tiene campos que se llenan desde el propio tablero:

- **Priority**: qué tan urgente es. La define el Product Owner.
- **Estimate**: esfuerzo estimado por el equipo (por ejemplo en puntos 1, 2, 3, 5, 8).
- **Iteration**: el sprint en el que se va a trabajar, si el tablero tiene ese campo.

Vistas útiles: **My items** para ver solo lo tuyo, **Priority board** para decidir qué sigue y **Roadmap** para la vista por fechas.

## Etiquetas

Las etiquetas son solo para clasificar; el estado y la prioridad viven en el tablero.

| Etiqueta | Uso |
|---|---|
| `tipo: ...` | La pone la plantilla automáticamente. |
| `área: ...` | Parte del sistema: backend, frontend, base de datos, diseño, QA, DevOps o documentación. |
| `bloqueado` | La issue no puede avanzar. Se deja en su columna y se avisa al Scrum Master. |

## Roles

| Rol | Responsabilidad |
|---|---|
| Product Owner | Decide qué se construye y en qué orden. Escribe y prioriza las historias y acepta el trabajo terminado. |
| Scrum Master | Organiza las reuniones, abre el registro de cada sprint y ayuda a quitar bloqueos. |
| Equipo de desarrollo | Estima, divide las historias en tareas, construye y prueba. |

## El sprint

Los sprints duran dos semanas.

| Reunión | Cuándo | Duración | Resultado |
|---|---|---|---|
| Planeación | Primer día | 1 a 2 horas | Objetivo del sprint e historias comprometidas, anotados en el registro de sprint. |
| Daily | Todos los días | 15 minutos | Cada quien revisa sus tarjetas y menciona bloqueos. |
| Refinamiento | A mitad del sprint | 1 hora | Historias del backlog con criterios claros y estimadas, listas para *Ready*. |
| Revisión | Último día | 1 hora | Demostración de lo terminado y comentarios del Product Owner. |
| Retrospectiva | Último día | 45 minutos | Qué mejorar en el siguiente sprint. Se cierra el registro de sprint. |

## Cuándo una historia está lista y cuándo está terminada

**Lista para empezar (Ready)**
- Describe quién la necesita, qué quiere y para qué.
- Tiene criterios de aceptación.
- Está estimada y no es demasiado grande (si pasa de 8 puntos, conviene dividirla).

**Terminada (Done)**
- Cumple todos sus criterios de aceptación.
- El código está fusionado mediante un pull request revisado por otra persona.
- Tiene pruebas cuando aplica.
- El Product Owner la aceptó.

---

## Administración

Esta sección es solo para quien administra la organización.

**Qué hay en este repositorio**

| Archivo | Función |
|---|---|
| `.github/ISSUE_TEMPLATE/` | Plantillas de issues. Aplican a todo repo de la organización que no tenga las suyas. |
| `.github/pull_request_template.md` | Plantilla de pull request. |
| `labels.json` | Etiquetas que deben existir en todos los repos. |
| `labels-obsoletas.txt` | Etiquetas que se eliminan de todos los repos. |
| `.github/workflows/add-to-project.yml` | Agrega al tablero las issues abiertas de todos los repos. Corre de forma periódica; GitHub decide el intervalo exacto. |
| `.github/workflows/sync-labels.yml` | Aplica `labels.json` y `labels-obsoletas.txt` en todos los repos. Corre cada lunes y al cambiar esos archivos. |
| `scripts/crear-equipos.sh` | Crea los equipos `product-owner`, `scrum-master` y `desarrollo`. |

**Token**

Los dos workflows usan el secreto de Actions `AKIRASOFTUTL` de este repositorio: un token *classic* con los permisos `repo`, `project` y `read:org`. Si el token vence, genera uno nuevo y reemplaza el valor del secreto.

**Repos nuevos**

No requieren configuración: reciben las plantillas, las etiquetas y su incorporación al tablero de forma automática. Para que las issues lleguen al tablero al instante, en lugar de esperar al workflow, se puede añadir el repo en *Workflows > Auto-add to project* del tablero.

**Cambiar de tablero**

Actualiza `PROJECT_NUMBER` en `.github/workflows/add-to-project.yml` y el enlace al inicio de esta guía.
