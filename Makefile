init:
	cp .env.sample .env

build:
	docker compose build
	docker compose run --rm web bundle install
	docker compose run --rm web bin/rails assets:precompile
	docker compose run --rm web bin/rails db:setup

rebuild:
	docker compose build
	docker compose run --rm web bundle install
	docker compose run --rm web bin/rails assets:precompile
	docker compose run --rm web bin/rails db:reset

run: build
	docker compose up -d

stop:
	docker compose down

console:
	run
	docker compose exec web rails console

logs:
	run
	docker compose exec web tail -f log/production.log