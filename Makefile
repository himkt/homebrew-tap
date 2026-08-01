.PHONY: formula api

# Homebrew reads formulae from taps only. HOMEBREW_DEVELOPER is its supported
# opt-out, letting the generator read this working tree so `make api` picks up
# edits that are not committed and pulled into the tap clone yet.
BREW_RUBY = HOMEBREW_DEVELOPER=1 brew ruby

formula:
ifndef REPO
	$(error REPO is required. Usage: make formula REPO=owner/name VERSION=x.y.z)
endif
ifndef VERSION
	$(error VERSION is required. Usage: make formula REPO=owner/name VERSION=x.y.z)
endif
	@python3 scripts/create-formula.py $(REPO) $(VERSION)
	@$(MAKE) api

api:
	@$(BREW_RUBY) scripts/generate-api.rb
