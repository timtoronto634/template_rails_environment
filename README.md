# template_rails_environment

This repository is a template for creating a rails 6 project.

It is based on docker quickstart: https://docs.docker.com/samples/rails/, but several improvement is introduced

* this repository is for rails 6, not 5.
* using this repository makes a project development-ready in linux.

# usage

1. clone this repo, chane the directory name or copy the directory as your project name
2. add your password for postgresql in `.env.db.dev`
3. run `docker-compose run --no-deps web bundle ex rails new . --force --database=postgresql`
4. modify `src/config/database.yaml` for db connection. 
an example is...
```
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password: your_password
```
5. run `docker-compose up -d` and `docker-compose exec web bundle ex rails db:create`
6. now access to `localhost:4000`. you should see "Yay! Ruby on Rails!"