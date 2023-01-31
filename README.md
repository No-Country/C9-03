# C9-03
Cohorte 9, grupo 3 Ruby on Rails

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

# Integrantes
### PLACEHOLDER
