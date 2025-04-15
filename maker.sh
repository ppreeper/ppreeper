#!/bin/sh
DEB=docs/debs

genrelease() {
    PD=${PWD}
    cd "${DEB}" || return
    dpkg-scanpackages . /dev/null >Release
    dpkg-scanpackages . /dev/null | gzip -9c >Packages.gz
    cd "${PD}" || return
}

genindex() {
    ls "${DEB}"/ | grep -v index.html | awk '{print "<a href=\""$0"\">"$0"</a></br>"}' >${DEB}/index.html
}

getoda() {
    rm -f docs/debs/oda*deb
    cp "${HOME}"/workspace/repos/ppreeper/odaspro/bin/*deb docs/debs/.
}

genhugo() {
    hugo -d docs
}

# Display usage instructions
usage() {
    echo "Usage: $0 {one|two|three}"
    exit 1
}

# Check if a parameter is provided
if [ $# -lt 1 ]; then
    usage
fi

# Use a case statement to call the corresponding function
case "$1" in
getoda)
    getoda
    ;;
two)
    function_two
    ;;
three)
    function_three
    ;;
*)
    usage
    ;;
esac

# vim: set ts=4 sw=4 et:
