# ExRush

## Installation and running this solution

  ### Pre Requirements 

  ```
  Erlang OTP 21+
  Elixir 1.9 + 
  Docker (one of the latest versions)
  ```

  Versions used for develpment:

  ```
  elixir          1.10.4-otp-23   
  erlang          23.2.1        
  docker          20.10.6
  docker-compose  1.29.1
  ``` 

### Starting application

  * Run postgres 10+ `docker run -d -p "5432:5432" --name postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres:13-alpine`
  * Get dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


### Starting elixir release in docker-compose setup

To run the application and the database in the elixir release mode run:

```
docker-compose -d up
```

`ex_rush` should be accessible at [`http://localhost:4000`](http://localhost:4000)


To stop containers run 

```
docker-compose down
```


You can run only database to run the unit test:

```
docker-compose run -d --service-ports postgres
```

followed by

```
mix test 
```
