# Makefile for github.com:TurtleEngr/WP-custom-field-shortcode

# ----------
# Macros

SHELL := /bin/bash

mProj = WP-custom-field-shortcode
mProduct = dist/custom-field-shortcode-VERSION.zip

mBuildList = \
    dist/custom-field-shortcode \
    dist/custom-field-shortcode/custom-field-shortcode.php \
    dist/custom-field-shortcode/readme.txt \
    dist/custom-field-shortcode/LICENSE

mServer = moria.whyayh.com
mPubDev = /rel/development/software/own/$(mProj)
mPubRel = /rel/released/software/own/$(mProj)

# --------------------

usage :
	@echo "update - get latest version from github"
	@echo "build - $(mProduct)"
	@echo "incPatch, incMinor, or incMajor - before save or publish"
	@echo "save - ci, push develop to github, copy to $(mPubDev)"
	@echo "publish - tag, ci, push to develop, merge to main,"
	@echo "    push to main, copy to $(mPubRel)"

update :
	git co develop
	git pull origin develop

build : dist-clean update README.md $(mProduct)
	@echo 'If OK, make save'

save development : check-dev
	git ci -am Updated
	git push origin develop
	-ssh $(mServer) mkdir -p $(mPubDev)
	rsync -a README.org readme.txt dist/custom-field-shortcode-$$(cat VERSION).zip $(mServer):$(mPubDev)
	cp VERSION VERSION-dev
	git ci -am Updated
	git push origin develop
	@echo 'If OK, make publish'

publish release : check-rel
	git tag -f "ver-$$(cat VERSION)"
	git push --tags origin develop
	git co main
	git pull --tags origin main
	git merge develop
	git push --tags origin main
	git co develop
	-ssh $(mServer) mkdir -p $(mPubRel)
	rsync -a README.org readme.txt dist/custom-field-shortcode-$$(cat VERSION).zip $(mServer):$(mPubRel)
	cp VERSION VERSION-rel
	git ci -am Updated
	git push origin develop
	@echo 'If done, make dist-clean'

clean :
	-find . -type f -name '*~' -exec rm {} \;

dist-clean : clean
	rm -rf dist


# To remove tags: local and remote
# git tag -d v2.1.1
# git push origin --delete v2.1.1

# --------------------
# Work Targets

$(mProduct) : $(mBuildList)
	php -l custom-field-shortcode.php
	cd dist; zip -r custom-field-shortcode-$$(cat ../VERSION).zip custom-field-shortcode
	-touch $@

README.md : README.org VERSION
	pandoc -f org -t markdown <README.org >$@
	sed -i "s/VERSION/$$(cat VERSION)/" $@
	sed -i 's/^\[version]/![version]/' $@
	sed -i 's/^\[WordPress]/![WordPress]/' $@

check-dev :
	if diff -q VERSION VERSION-dev; then \
		echo "Development versions must be different."; \
		echo "increment and rebuild."; \
		exit 1; \
	fi

check-rel :
	if diff -q VERSION VERSION-rel; then \
		echo "Released versions must be different."; \
		echo "increment and rebuild."; \
		exit 1; \
	fi

# --------------------
# Single Targets

VERSION :
	echo '0.0.0' >$@

incPatch : VERSION
	incver.sh -p

incMinor : VERSION
	incver.sh -m

incMajor : VERSION
	incver.sh -M

dist/custom-field-shortcode :
	mkdir -p $@

dist/custom-field-shortcode/custom-field-shortcode.php : VERSION custom-field-shortcode.php
	sed "s/VERSION/$$(cat VERSION)/" <custom-field-shortcode.php >$@

dist/custom-field-shortcode/readme.txt : VERSION readme.txt
	sed "s/VERSION/$$(cat VERSION)/" <$? >$@

dist/custom-field-shortcode/LICENSE : LICENSE
	-cp $? $@
