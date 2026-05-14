#!/usr/bin/env sh
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
    echo "Usage: $0 {genhugo|pushrepo|build|all}"
    exit 1
}

# Check if a parameter is provided
if [ $# -lt 1 ]; then
    usage
fi

# Use a case statement to call the corresponding function
case "$1" in
genhugo)
    genhugo
    ;;
pushrepo)
    pushrepo
    ;;
build)
    genhugo
    ;;
all)
    genhugo
    pushrepo
    ;;
*)
    usage
    ;;
esac

# vim: set ts=4 sw=4 et:
