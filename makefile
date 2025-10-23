deploy: build
	git add docs/
	git commit -m "update GitHub Pages"
	git push origin main

build: clean
	mkdir -p docs/
	docker compose exec wiki /bin/sh -c 'npx quartz build && cp -r public/* /tmp/docs/'

clean:
	rm -rf docs/
