#!/bin/bash

gen_release() {
	dpkg-scanpackages docs/deb /dev/null > docs/deb/Release
	dpkg-scanpackages docs/deb /dev/null | grep -9c > docs/deb/Packages
}

get_oda() {
	REPO="https://github.com/ppreeper/oda"
	vers=$(git ls-remote --tags ${REPO} | grep "refs/tags.*[0-9]$" | awk '{print $2}' | sed 's/refs\/tags\///' | sort -V | uniq | tail -1 | sed 's/^v//')
	rm -f docs/deb/odaserver*_amd64.deb
	wget -qO docs/deb/odaserver_${vers}_amd64.deb "${REPO}/releases/download/v${vers}/odaserver_${vers}_amd64.deb"
	rm -f docs/deb/odacli*_amd64.deb
	wget -qO docs/deb/odacli_${vers}_amd64.deb "${REPO}/releases/download/v${vers}/odacli_${vers}_amd64.deb"
}

get_oda

gen_release
