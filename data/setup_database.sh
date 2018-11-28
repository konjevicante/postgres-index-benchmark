#!/bin/bash

# Setup
psql -U postgres -d postgres -c "CREATE EXTENSION btree_gist"
psql -U postgres -d postgres -c "CREATE SCHEMA exercise"
psql -U postgres -d postgres -c "CREATE TABLE exercise.users (id uuid PRIMARY KEY, username VARCHAR NOT NULL)"
psql -U postgres -d postgres -c "CREATE TABLE exercise.user_login_tokens ( id serial PRIMARY KEY, user_id uuid NOT NULL, token uuid NOT NULL, expires_at TIMESTAMPTZ NOT NULL )"
psql -U postgres -d postgres -f /data/users_and_tokens.sql