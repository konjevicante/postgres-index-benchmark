#!/bin/bash

# Teardown
psql -U postgres -d postgres -c "DROP TABLE IF EXISTS exercise.user_login_tokens"
psql -U postgres -d postgres -c "DROP TABLE IF EXISTS exercise.users"
psql -U postgres -d postgres -c "DROP SCHEMA IF EXISTS exercise"
