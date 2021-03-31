REMOTE := "efertone"
BUCKET := "share-efertone"
BASE_PATH := "final-space"

.PHONY: dev-build
dev-build:
	elm make src/Main.elm --output=public/application.js --debug

.PHONY: prod-build
prod-build:
	elm make src/Main.elm --output=public/application.js

.PHONY: upload
upload: prod-build
	mc cp public/index.html $(REMOTE)/$(BUCKET)/$(BASE_PATH)/index.html
	mc cp public/application.js $(REMOTE)/$(BUCKET)/$(BASE_PATH)/application.js
	mc cp public/application.css $(REMOTE)/$(BUCKET)/$(BASE_PATH)/application.css

.PHONY: gen-videos-json
gen-videos-json:
	@echo '[$(shell mc ls $(REMOTE)/$(BUCKET)/$(BASE_PATH)/videos/ --json | \
			jq -r '.key' | \
			sed -Ee 's/\.mkv$$|\.mp4$$//g' | \
			sort -u | \
			sed -Ee 's/^(.*)$$/{"Title":"\1","Path":"videos\/\1"}/g' | \
			paste -sd "," -)]' > public/videos.json

.PHONY: update-videos
update-videos: gen-videos-json
	mc cp public/videos.json $(REMOTE)/$(BUCKET)/$(BASE_PATH)/videos.json

start-dev-server:
	python3 -m http.server --directory public
