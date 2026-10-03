YEAR := $(shell date +"%Y")
MONTH := $(shell date +"%m")
DAY := $(shell date +"%d")
TITLE := $(shell tr -dc A-Za-z0-9 </dev/urandom | head -c 4)

help:
	@echo 'make post: create a new post'
	@echo ''
	@echo 'make serve or make s: preview this site, include drafts'
	@echo ''
	@echo 'make or make help: show this help'
	@echo ''

post:
	~/apps/hugo new content content/posts/$(YEAR)/$(MONTH)/$(TITLE).md

serve s:
	~/apps/hugo server --buildDrafts --noBuildLock --openBrowser
