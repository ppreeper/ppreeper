.DEFAULT_GOAL := all

DEB = docs/debs
PD := ${PWD}

.PHONY: genrelease
genrelease:
	cd ${DEB}
	dpkg-scanpackages . /dev/null > Release
	dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
	cd ${PD}

.PHONY: genindex
genindex:
	ls ${DEB}/ | grep -v index.html | awk '{print "<a href=\""$0"\">"$0"</a></br>"}' > ${DEB}/index.html

.PHONY: getoda
getoda:
	rm -f docs/debs/oda*deb
	cp ${HOME}/workspace/repos/ppreeper/odaspro/bin/*deb docs/debs/.

.PHONY: genhugo
genhugo:
	hugo -d docs
	git add docs
	git commit -am "docs `date`"

.PHONY: pushrepo
pushrepo:
	git add .
	git commit -am "repo `date`"
	git push

.PHONY: all
all: getoda genrelease genindex genhugo pushrepo
