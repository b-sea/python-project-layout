VENV_ROOT=.venv

ifeq ($(OS),Windows_NT)
	VENV_BIN=${VENV_ROOT}/Scripts
else
	VENV_BIN=${VENV_ROOT}/bin
endif

.PHONY: docs requirements src tests venv

venv:
	@python -m venv ${VENV_ROOT}
	@${VENV_BIN}/python -m pip install pip==21.2 pip-tools==5.5.0

clean-venv:
	rm -rf ${VENV_ROOT}

setup:
	@pip-sync requirements/dev.txt requirements/docs.txt requirements/test.txt --force
	@pip install -e .
	@touch .env

freeze:
	@pip-compile requirements/dev.in --no-emit-index-url
	@pip-compile requirements/docs.in --no-emit-index-url
	@pip-compile requirements/test.in --no-emit-index-url

update-freeze:
	@pip-compile requirements/dev.in --upgrade --no-emit-index-url
	@pip-compile requirements/docs.in --upgrade --no-emit-index-url
	@pip-compile requirements/test.in --upgrade --no-emit-index-url

docs: clean-docs
	@sphinx-build -a -E -b html ./docs ./build/docs

clean-docs:
	rm -rf ./build/docs

test:
	@python -m unittest discover -v

coverage:
	@coverage run --rcfile=setup.cfg -m unittest discover -v
	@coverage report
	@coverage html

clean-coverage:
	rm -rf .coverage
	rm -rf ./htmlcov

lint:
	@pylint --rcfile=setup.cfg src

build: clean-build
	@python -m build --wheel

clean-build:
	rm -rf ./build
	rm -rf ./dist

clean-all: clean-build clean-coverage clean-docs clean-venv
	rm -rf ./src/*.egg-info
