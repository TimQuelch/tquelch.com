.PHONY: build export deploy clean deps

export:
	emacs -Q --batch \
	--script build/export-init.el \
	--visit=content.org \
	--eval="(org-hugo-export-wim-to-md :all-subtrees)" \
	--kill

build:
	hugo --minify --verbose

deploy:
	hugo deploy --verbose

clean:
	rm -rfv content public resources

deps:
	mkdir -p assets/css/fontawesome static/webfonts && npm install && npm run build
