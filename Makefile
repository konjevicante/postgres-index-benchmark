up:
	sh ./users_and_tokens.sh
	docker run -d -it -v "$$PWD"/data:/data --name postgres-benchmark postgres
	docker exec -it $$(docker ps -f name=postgres-benchmark -q) bash -c 'sleep 5 ; sh /data/execute.sh'

down:
	docker stop $$(docker ps -a -f name=postgres-benchmark -q)
	docker rm $$(docker ps -a -f name=postgres-benchmark -q)

.PHONY: up down