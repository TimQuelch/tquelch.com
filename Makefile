.PHONY: build export deploy

export:
	emacs -Q --batch \
	--script export-init.el \
	--visit=content.org \
	--eval="(org-hugo-export-wim-to-md :all-subtrees)" \
	--kill

build:
	hugo --minify --verbose

deploy:
	hugo deploy --verbose
