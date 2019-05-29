# README

## Database Creation

If you are running it for the first time, you need to create a database on PostgreSQL.

$ sudo -u postgres -i psql

```
postgres=# CREATE USER test WITH PASSWORD 'test';
postgres=# CREATE DATABASE reservation;
postgres=# GRANT ALL PRIVILEGES ON  DATABASE reservation to test;
postgres=# ALTER DATABASE reservation owner to test;
postgres=# CREATE DATABASE reservation_test;
postgres=# GRANT ALL PRIVILEGES ON  DATABASE reservation_test to test;
postgres=# ALTER DATABASE reservation_test owner to test;
```
## Run Migrations

Once you have all containres running, execute the command command in a new terminal to run migrations:

```
`rake db:migrate`
`rake db:migrate RAILS_ENV=test`
```

## Start Application

You can run the following command to start all the application:

`rails s`

## API Documentation

You can refer the following documentation for API request:

`http://localhost:3000/api/docs`

## Test Application

You can run the following command to test all the test cases:

`rspec .`
