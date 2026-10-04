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
| Pruebas (QA) | Probar una historia o tarea antes de darla por terminada. | QA o quien revise |
| Épica | Un objetivo grande que agrupa varias historias. | Product Owner |
| Registro de sprint | Una por sprint, para dejar constancia del objetivo, la revisión y la retrospectiva. | Scrum Master |

Para relacionar issues usa **Create sub-issue** dentro de la issue padre: épica > historias > tareas y pruebas. El tablero muestra el avance de cada una.

## Casos comunes

**Tengo una historia de usuario. ¿Dónde la creo?**
En el repositorio donde se va a programar, con la plantilla *Historia de usuario*. Si la historia necesita cambios en varios repos (por ejemplo backend y frontend), créala en el repo principal del producto y agrega las tareas de cada repo como sub-issues. Las sub-issues pueden estar en repositorios distintos al de la historia.

**Quiero agregar un CRUD a un módulo.**
Depende de para quién es el cambio:
- Si alguien va a usarlo (por ejemplo, el administrador da de alta y edita productos), es una **historia**: "Como administrador quiero gestionar los productos para mantener el catálogo al día". Dentro, crea una tarea por pieza técnica: modelo y migración, endpoints, validaciones, pantallas y pruebas.
- Si es una pieza técnica que otra historia ya necesita, es una **tarea** dentro de esa historia.
- Si la historia pasa de 8 puntos, divídela, por ejemplo una para consultar y otra para crear, editar y eliminar.

**Quiero hacerle QA a una issue.**
1. Cuando la historia llega a *In review*, abre la historia y usa **Create sub-issue** con la plantilla *Pruebas (QA)*.
2. Escribe un caso de prueba por cada criterio de aceptación y márcalos conforme los compruebas.
3. Si algo falla, abre un *Reporte de error* como sub-issue de la misma historia y regresa la historia a *In progress*.
4. Si todo pasa, cierra la issue de pruebas. La historia puede pasar a *Done* cuando sus pull requests estén fusionados en `dev`.

QA prueba sobre la rama `dev`, que es donde se fusiona cada tarea terminada. Para probar un pull request antes de fusionarlo: `gh pr checkout <número>`.

**Una issue está detenida por algo externo.**
Ponle la etiqueta `bloqueado`, deja un comentario con el motivo y avisa al Scrum Master. No la cambies de columna.

**Encontré un error mientras trabajaba en otra cosa.**
Abre un *Reporte de error* aparte en lugar de arreglarlo dentro del mismo pull request, salvo que sea parte de lo que estás haciendo.

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

## Ramas, commits y pull requests

Ver [CONTRIBUTING.md](CONTRIBUTING.md).

## Etiquetas

Las etiquetas son solo para clasificar; el estado y la prioridad viven en el tablero.

| Etiqueta | Uso |
|---|---|
| `tipo: ...` | La pone la plantilla automáticamente: historia, tarea, bug, qa, épica o sprint. |
| `área: ...` | Parte del sistema: backend, frontend, base de datos, diseño, QA, DevOps o documentación. |
| `bloqueado` | La issue no puede avanzar. Se deja en su columna y se avisa al Scrum Master. |

## Roles

| Rol | Responsabilidad |
|---|---|
| Product Owner | Decide qué se construye y en qué orden. Escribe y prioriza las historias y acepta el trabajo terminado. |
| Scrum Master | Organiza las reuniones, abre el registro de cada sprint y ayuda a quitar bloqueos. |
| Equipo de desarrollo | Estima, divide las historias en tareas, construye y prueba. |

## El sprint

Los sprints duran una semana, de lunes a sábado.

| Reunión | Cuándo | Duración | Resultado |
|---|---|---|---|
| Planeación | Lunes | 45 minutos | Objetivo del sprint e historias comprometidas, anotados en el registro de sprint. |
| Daily | Lunes a sábado | 10 minutos (puede ser por mensaje) | Cada quien revisa sus tarjetas y menciona bloqueos. |
| Refinamiento | Miércoles | 30 minutos | Historias del backlog con criterios claros y estimadas, listas para *Ready*. |
| Revisión | Sábado | 30 minutos | Demostración de lo terminado y comentarios del Product Owner. |
| Retrospectiva | Sábado, después de la revisión | 15 minutos | Qué mejorar en el siguiente sprint. Se cierra el registro de sprint. |

## Cuándo una historia está lista y cuándo está terminada

**Lista para empezar (Ready)**
- Describe quién la necesita, qué quiere y para qué.
- Tiene criterios de aceptación.
- Está estimada y no es demasiado grande (si pasa de 8 puntos, conviene dividirla).

**Terminada (Done)**
- Cumple todos sus criterios de aceptación.
- El código está fusionado en `dev` mediante un pull request revisado por otra persona. Llega a `main` con el pull request de cierre del sprint.
- Pasó sus pruebas de QA.
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
| `CONTRIBUTING.md` | Reglas para ramas, commits y pull requests. Aplica a todos los repos. |
| `scripts/crear-equipos.sh` | Crea los equipos `product-owner`, `scrum-master` y `desarrollo`. |

**Token**

Los dos workflows usan el secreto de Actions `AKIRASOFTUTL` de este repositorio: un token *classic* con los permisos `repo`, `project` y `read:org`. Si el token vence, genera uno nuevo y reemplaza el valor del secreto.

**Repos nuevos**

No requieren configuración: reciben las plantillas, las etiquetas y su incorporación al tablero de forma automática. Para que las issues lleguen al tablero al instante, en lugar de esperar al workflow, se puede añadir el repo en *Workflows > Auto-add to project* del tablero.

**Workflows programados**

GitHub desactiva los workflows programados de un repositorio público cuando pasa 60 días sin actividad. Si deja de llegar trabajo al tablero, revisa *Actions* en este repo y reactívalo con *Enable workflow*.

**Cambiar de tablero**

Actualiza `PROJECT_NUMBER` en `.github/workflows/add-to-project.yml` y el enlace al inicio de esta guía.
