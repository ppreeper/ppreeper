#!/usr/bin/env sh
DEB=docs/debian

genrelease() {
    PD=${PWD}
    cd "${DEB}" || return
    dpkg-scanpackages --arch amd64 pool/main > dists/stable/main/binary-amd64/Packages
    gzip -fk dists/stable/main/binary-amd64/Packages
    cd "${PD}" || return
    cat >dists/stable/main/binary-amd64/Release <<EOF
Component: main
Architecture: amd64
EOF
}
:workspace
getoda() {
    rm -fv "${DEB}"/pool/main/o/oda*deb
    mkdir -p "${DEB}"/pool/main/o
    cp -v "${HOME}"/repos/ppreeper/odaspro/bin/*deb "${DEB}"/pool/main/o/.
}

genhugo() {
    hugo -d docs
}

pushrepo() {
    git add .
    git commit -am "repo $(date)"
    git push
}

# Display usage instructions
usage() {
    echo "Usage: $0 {getoda|genrelease|genindex|genhugo|makerepo|pushrepo|build|all}"
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
genrelease)
    genrelease
    ;;
genindex)
    genindex
    ;;
genhugo)
    genhugo
    ;;
makerepo)
    getoda
    genrelease
    genindex
    ;;
pushrepo)
    pushrepo
    ;;
build)
    getoda
    genrelease
    genindex
    genhugo
    ;;
all)
    getoda
    genrelease
    # genindex
    genhugo
    pushrepo
    ;;
*)
    usage
    ;;
esac

# vim: set ts=4 sw=4 et:
