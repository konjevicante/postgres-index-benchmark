#!/bin/bash

uuid()
{
    local N B C='89ab'

    for (( N=0; N < 16; ++N ))
    do
        B=$(( $RANDOM%256 ))

        case $N in
            6)
                printf '4%x' $(( B%16 ))
                ;;
            8)
                printf '%c%x' ${C:$RANDOM%${#C}:1} $(( B%16 ))
                ;;
            3 | 5 | 7 | 9)
                printf '%02x-' $B
                ;;
            *)
                printf '%02x' $B
                ;;
        esac
    done

    echo
}

username()
{
    hexdump -n 16 -v -e '/1 "%02X"' -e '/16 "\n"' /dev/urandom
    echo
}

> data/users_and_tokens.sql
> data/search_tokens.txt

USER_COUNTER=0
while [  $USER_COUNTER -lt 100 ]; do
  user_id=$(uuid)
  printf "INSERT INTO exercise.users (id, username) VALUES (%s, %s); \n" "'$user_id'" "'$(username)'" >> data/users_and_tokens.sql
  USER_KEY_COUNTER=0
  while [  $USER_KEY_COUNTER  -lt 100 ]; do
    token=$(uuid)
    if [ "$USER_KEY_COUNTER" = 1 ]; then
        printf "%s\n" "$token" >> data/search_tokens.txt
    fi
    printf "INSERT INTO exercise.user_login_tokens (user_id, token, expires_at) VALUES (%s, %s, %s); \n" "'$user_id'" "'$token'" "'2018-12-01 08:00:00+00'"  >> data/users_and_tokens.sql
    let USER_KEY_COUNTER=USER_KEY_COUNTER+1
  done
  let USER_COUNTER=$USER_COUNTER+1
done