.PHONY: build deps composer-install composer-update composer reload test run-tests start stop destroy doco rebuild start-local

current-dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

build: deps start

deps: composer-install

# 🐘 Composer
composer-install: CMD=install
composer-update: CMD=update
composer composer-install composer-update:
	@docker run --rm --interactive --user $(id -u):$(id -g) \
		--volume $(current-dir):/app \
		--volume ${HOME}/.composer:/tmp \
		composer $(CMD) \
			--ignore-platform-reqs \
			--no-ansi \
			--no-interaction

reload:
	@docker compose exec php-fpm kill -USR2 1
	@docker compose exec nginx nginx -s reload

test:
	@docker exec github-actions_php make run-tests

run-tests:
	mkdir -p build/test_results/phpunit
	./vendor/bin/phpunit --exclude-group='disabled' --log-junit build/test_results/phpunit/junit.xml tests

# 🐳 Docker Compose
start: CMD=up -d
stop: CMD=stop
destroy: CMD=down

# Usage: `make doco CMD="ps --services"`
# Usage: `make doco CMD="build --parallel --pull --force-rm --no-cache"`
doco start stop destroy:
	@docker compose $(CMD)

rebuild:
	docker compose build --pull --force-rm --no-cache
	make deps
	make start
