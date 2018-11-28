# Benchmarking postgres indexes

```
$ docker run -d -it -v "$PWD"/data:/data --name postgres-benchmark postgres
$ docker ps -a
$ docker exec -it $(docker ps -f name=postgres-benchmark -q) bash
```

0. access psql
1. create schema
2. create table users
3. create table user_login_tokens
4. populate table users
5. populate table user_login_tokens
6. create index for user_login_tokens
7. simulate a lot of records and heavy load

0. access psql

``` psql -U postgres -d postgres ```

1. create schema

```
postgres=# CREATE SCHEMA exercise;
postgres=# select * from information_schema.schemata;
```

2. create table users

```
postgres=# CREATE TABLE exercise.users (id uuid PRIMARY KEY, username VARCHAR NOT NULL);
postgres=# SELECT * FROM information_schema.tables WHERE table_schema = 'exercise';
postgres=# \dt exercise.*
postgres=# SELECT * FROM exercise.users;
```

3. create table user_login_tokens

```
postgres=# CREATE TABLE exercise.user_login_tokens ( id serial PRIMARY KEY, user_id uuid NOT NULL, token uuid NOT NULL, expires_at TIMESTAMPTZ NOT NULL );
postgres=# SELECT * FROM information_schema.tables WHERE table_schema = 'exercise';
postgres=# \dt exercise.*
postgres=# SELECT * FROM exercise.user_login_tokens;
```

4. populate users and user_login_tokens table
5. populate table user_login_tokens

``` $ execute.sh ```

6. create index for user_login_tokens
7. simulate a lot of records and heavy load



