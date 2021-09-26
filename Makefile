SHELL := /bin/bash
pwd := ${PWD}
dirname := $(notdir $(patsubst %/,%,$(CURDIR)))
.DEFAULT_GOAL := list

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

list:
	@grep -oE '^[^#[:space:]]([^ ]*):' Makefile


.venv:
	poetry env use "$$(cat .python-version)"

install: .venv
	poetry install

splunk-packaging-toolkit-1.0.1.tar.gz:
	poetry run pip download --no-deps splunk-packaging-toolkit==1.0.1 -d ./

splunk-packaging-toolkit-1.0.1/setup.py: splunk-packaging-toolkit-1.0.1.tar.gz
	tar -xzf splunk-packaging-toolkit-1.0.1.tar.gz


dist: build
build: .venv splunk-packaging-toolkit-1.0.1/setup.py
	pushd ./splunk-packaging-toolkit-1.0.1; \
	sed -i 's#if self.should_create_symlink()#if False#g' ./setup.py; \
	poetry run python setup.py bdist_wheel