CURRENT_YEAR := $(shell date +"%Y")

new-post:
	hugo new content content/posts/$(CURRENT_YEAR)/title.md
