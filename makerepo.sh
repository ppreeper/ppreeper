#!/bin/bash
DEB="docs/debs"

gen_release() {
	PD=${PWD}
	cd ${DEB}
	dpkg-scanpackages . /dev/null > Release
	dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
	cd ${PD}
}

gen_index() {
	ls ${DEB}/ | grep -v index.html | awk '{print "<a href=\""$0"\">"$0"</a></br>"}' > ${DEB}/index.html
}

get_oda() {
	REPO="https://github.com/ppreeper/oda"
	vers=$(git ls-remote --tags ${REPO} | grep "refs/tags.*[0-9]$" | awk '{print $2}' | sed 's/refs\/tags\///' | sort -V | uniq | tail -1 | sed 's/^v//')
	rm -f ${DEB}/odacli*_amd64.deb
	wget -qO ${DEB}/odacli_${vers}_amd64.deb "${REPO}/releases/download/v${vers}/odacli_${vers}_amd64.deb"
}

get_odas() {
	REPO="https://github.com/ppreeper/odas"
	vers=$(git ls-remote --tags ${REPO} | grep "refs/tags.*[0-9]$" | awk '{print $2}' | sed 's/refs\/tags\///' | sort -V | uniq | tail -1 | sed 's/^v//')
	rm -f ${DEB}/odaserver*_amd64.deb
	wget -qO ${DEB}/odaserver_${vers}_amd64.deb "${REPO}/releases/download/v${vers}/odaserver_${vers}_amd64.deb"
}

#get_oda
#get_odas

gen_release
gen_index
