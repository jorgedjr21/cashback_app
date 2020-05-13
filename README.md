# Cashback_app

Simple offer register for a cashback app

## How to install

 **Requiriments** 
 - Docker
 - docker-compose (optional)
 - MySQL runing in some server (docker or local)

1 - Clone or download this repo [Download Link](https://github.com/jorgedjr21/cashback_app/releases)

2 - Open the repo folder and them
```shell
  docker-compose build
  docker-compose run --rm cashback_app bash
  
  # Inside the docker-container
  bundle install && rails db:setup
  exit
  
  # After exiting the container
  docker-compose up cashback_app
```

**The test user has email: test@test.com and password: 123456**


**OR**

Run the project localy: (ps: You will need rails and bundler installed in your machine!)

1 - Clone or download this repo [Download Link](https://github.com/jorgedjr21/cashback_app/releases)

2 - Configure the database.yml file inside the config/ folder

```yml
  default: &default
    adapter: postgresql
    encoding: utf8mb4
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    host: # UPDATE THE HOST TO YOUR LOCAL MYSQL
    username: # UPDATE THE USERNAME TO YOUR LOCAL DB USERNAME
    password: # UPDATE THE PASSWORD TO YOUR LOCAL DB PASWORD
```

3 - Install gems, create the database and the migrations

```shell
  bundle install && rails db:setup
```

4 - Up the application and access it

```shell
  rails s -b 0.0.0.0 -p 3000
```

## Tests and Coverage

- To run the tests, you can use this comand (inside docker or locally, depends how you run the application):
-- `bundle exec rspec`

### Other Infos

You can find the docker hub repository of this repo here:

https://hub.docker.com/repository/docker/jorgedjr21/cashback_app
