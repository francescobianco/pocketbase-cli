
start:
	@docker compose up -d --force-recreate && sleep 1
	@docker compose exec pb sh -c "./pb/pocketbase superuser upsert demo@javanile.org Demo1234"
	@echo "Open this link <http://localhost:8888/_/#login>"

push:
	@git add .
	@git commit -am "New release!" || true
	@git push

test-insert:
	@#node tests/insert-test.js
	@rm -f .pocketbaserc.token
	@mush run -- insert Test
