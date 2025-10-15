CURRENT_YEAR := $(shell date +"%Y")
DATE := $(shell date +"%m-%d")

new-post:
	hugo new content content/posts/$(CURRENT_YEAR)/$(DATE).md
