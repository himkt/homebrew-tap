.PHONY: formula api

formula:
ifndef REPO
	$(error REPO is required. Usage: make formula REPO=owner/name VERSION=x.y.z)
endif
ifndef VERSION
	$(error VERSION is required. Usage: make formula REPO=owner/name VERSION=x.y.z)
endif
	@python3 scripts/create-formula.py $(REPO) $(VERSION)
	@python3 scripts/generate-api.py

api:
	@python3 scripts/generate-api.py
