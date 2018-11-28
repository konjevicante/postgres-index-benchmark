#!/bin/bash

> $(dirname $0)/results.txt

# INDEX - B-tree
sh /data/setup_database.sh
psql -U postgres -d postgres -c "CREATE INDEX btree_tokenx ON exercise.user_login_tokens USING btree (token)"

printf "############################################################################################################\n" >> $(dirname $0)/results.txt
printf "############################################## INDEX - B-tree ##############################################\n" >> $(dirname $0)/results.txt
printf "############################################################################################################\n\n\n" >> $(dirname $0)/results.txt

while read TOKEN  ; do
    QUERY_TIME=$(psql -U postgres -d postgres -c "EXPLAIN ANALYZE SELECT * FROM exercise.user_login_tokens WHERE token = '$TOKEN'")
    printf "%s\n" "$QUERY_TIME" >> $(dirname $0)/results.txt
done <$(dirname $0)/search_tokens.txt

sh /data/teardown_database.sh

# INDEX - GiST
sh /data/setup_database.sh
psql -U postgres -d postgres -c "CREATE INDEX gist_tokenx ON exercise.user_login_tokens USING gist (token)"

printf "\n\n############################################################################################################\n" >> $(dirname $0)/results.txt
printf "##############################################  INDEX - GiST  ##############################################\n" >> $(dirname $0)/results.txt
printf "############################################################################################################\n\n\n" >> $(dirname $0)/results.txt

while read TOKEN  ; do
    QUERY_TIME=$(psql -U postgres -d postgres -c "EXPLAIN ANALYZE SELECT * FROM exercise.user_login_tokens WHERE token = '$TOKEN'")
    printf "%s\n" "$QUERY_TIME" >> $(dirname $0)/results.txt
done <$(dirname $0)/search_tokens.txt

sh /data/teardown_database.sh
# INDEX - GIN
sh /data/setup_database.sh

# If consistent response time is more important than update speed, use of pending entries
# can be disabled by turning off the fastupdate storage parameter for a GIN index.
psql -U postgres -d postgres -c "CREATE INDEX gin_tokenx ON exercise.user_login_tokens USING btree_gin (token) WITH (fastupdate = off)"

printf "\n\n############################################################################################################\n" >> $(dirname $0)/results.txt
printf "##############################################  INDEX - GIN  ###############################################\n" >> $(dirname $0)/results.txt
printf "############################################################################################################\n\n\n" >> $(dirname $0)/results.txt

while read TOKEN  ; do
    QUERY_TIME=$(psql -U postgres -d postgres -c "EXPLAIN ANALYZE SELECT * FROM exercise.user_login_tokens WHERE token = '$TOKEN'")
    printf "%s\n" "$QUERY_TIME" >> $(dirname $0)/results.txt
done <$(dirname $0)/search_tokens.txt

sh /data/teardown_database.sh

exit