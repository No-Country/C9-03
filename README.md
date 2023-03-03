# C9-03
Cohorte 9, grupo 3 Ruby on Rails

Información importante:

Seguir este flujo respecto a las branches:
![Untitled 1_page-0001](https://user-images.githubusercontent.com/78238453/217380159-b1913c2d-6c65-447c-88eb-1020d7663e90.jpg)

La rama de Main es la base de los deploys, tiene configuraciones especiales y por lo tanto se debe hacer pull desde develop y evitar pushear a main.

Los PRs con features deben hacerse a release, luego cada jueves debe pushearse lo que se haya logrado meter en el release a development y de allí se debe pushear a main para hacer el deploy. Luego, cuando comienza el nuevo sprint, debe hacerse un pull de development para traer la versión actualizada. 



Para inicializar el proyecto, puedes hacerlo con Docker (recomendado) o localmente.

Para hacerlo con Docker, importante tener docker compose instalado (sigue esta guía https://docs.docker.com/compose/install/). 

CD a la repo

`cd C9-03`

Build imagenes
`docker compose build`

Levantar container
`docker compose up`

Crear la BD
`docker compose run web rake db:setup`

(migra el schema cada vez que sea necesario)
`docker compose run web rake db:migrate`

Para ejecutarlo localmente, elimina "config/database.yml" y renombra "config/database.yml.example" por "config/database.yml" (NO incluyás ese archivo en los commits, aunque si lo incluí en el gitignore), luego crea la BD

`rails db:create`

y ejecuta el server

`rails s`

(recuerda instalar el bundle primero)



## Información:
### Trello (Agile management)
https://trello.com/b/FdZaGEtn


## Recursos / Recomendaciones
### Agregá abajo algún recurso, lectura, tutorial, tip o consejo que consideres puede ser de ayuda y/o de referencia
#### Rails
https://www.rubylearning.dev/

#### Git

https://www.w3schools.com/git/

### Releases:

## Semana 4:
https://yendo.graciani.ar

# Integrantes
- Lautaro Graciani, FullStack
- María Martin, UX-UI / Front end
- Rocío Godoy, Fullstack
- Rodrigo Ladron de Guevara, Backend
