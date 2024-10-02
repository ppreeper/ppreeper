#!/bin/bash
DEB="docs/debs"

gen_release() {
	dpkg-scanpackages ${DEB} /dev/null > docs/debs/Release
	dpkg-scanpackages ${DEB} /dev/null | grep -9c > docs/debs/Packages
}

get_oda() {
	REPO="https://github.com/ppreeper/oda"
	vers=$(git ls-remote --tags ${REPO} | grep "refs/tags.*[0-9]$" | awk '{print $2}' | sed 's/refs\/tags\///' | sort -V | uniq | tail -1 | sed 's/^v//')
	rm -f ${DEB}/odaserver*_amd64.deb
	wget -qO ${DEB}/odaserver_${vers}_amd64.deb "${REPO}/releases/download/v${vers}/odaserver_${vers}_amd64.deb"
	rm -f ${DEB}/odacli*_amd64.deb
	wget -qO ${DEB}/odacli_${vers}_amd64.deb "${REPO}/releases/download/v${vers}/odacli_${vers}_amd64.deb"
}

get_oda

gen_release
