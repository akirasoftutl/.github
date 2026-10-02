# Cómo contribuir

Reglas para todos los repositorios de AkiraSoft UTL. La forma de organizar el trabajo está en la [guía de trabajo](https://github.com/akirasoftutl/.github/blob/main/SCRUM.md).

## Antes de empezar

1. Toma una issue de la columna *Ready* del tablero.
2. Asígnatela y muévela a *In progress*.

## Ramas

Nunca se trabaja directamente sobre `main`. Crea una rama a partir de `main` con este formato:

```
tipo/numero-descripcion-corta
```

| Tipo | Uso | Ejemplo |
|---|---|---|
| `feature` | Funcionalidad nueva | `feature/12-registro-usuarios` |
| `fix` | Corrección de un error | `fix/31-error-500-login` |
| `chore` | Configuración, dependencias, limpieza | `chore/40-actualizar-dependencias` |
| `docs` | Solo documentación | `docs/45-readme-instalacion` |

El número es el de la issue. Así cualquiera sabe a qué tarea pertenece la rama.

## Commits

Mensajes cortos, en presente y en español, empezando con el tipo:

```
feat: agregar endpoint de registro
fix: validar correo vacío en el login
chore: actualizar dependencias
docs: explicar variables de entorno
test: agregar pruebas del registro
```

Un commit por cambio lógico. Evita mensajes como "cambios" o "avance".

## Pull requests

1. Abre el pull request hacia `main` cuando el trabajo esté listo para revisarse y mueve la issue a *In review*.
2. En la descripción escribe `Closes #numero`. Así la issue se cierra y pasa a *Done* al fusionar.
3. Pide revisión a por lo menos un compañero. No fusiones tu propio pull request sin revisión.
4. Mantén los pull requests pequeños: uno por issue.
5. Al fusionar, borra la rama.

## Revisar el pull request de alguien más

- Comprueba que cumple los criterios de aceptación de la issue.
- Si pides cambios, explica qué y por qué.
- Si todo está bien, aprueba con *Approve*.
