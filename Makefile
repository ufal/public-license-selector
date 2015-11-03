.PHONY: build

build:
	@npm run build

install:
	@npm install

run:
	@echo "**************************************************"
	@echo "* open http://localhost:8080/webpack-dev-server/ *"
	@echo "**************************************************"
	@npm start

release:
	@./node_modules/.bin/mversion patch

release-minor:
	@./node_modules/.bin/mversion minor

release-major:
	@./node_modules/.bin/mversion major
