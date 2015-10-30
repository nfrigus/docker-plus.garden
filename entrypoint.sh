#!/bin/sh


LOCK=/var/run/npm-install.pid



is_npm_ok () {
    if [ `npm list 2>&1 >/dev/null | awk '/^npm (ERR|WARN)/' | grep -v 'npm ERR! extraneous:' | wc -l` = 0 ]
    then return 0
    else return 1
    fi
}

npm_install () {
    [[ $1 = "clean" ]] && rm -rf node_modules/*
    until is_npm_ok; do
        npm list 2>&1 >/dev/null | awk '/^npm (ERR|WARN)/' | grep -v 'npm ERR! extraneous:' | wc -l
        npm install
        npm_install clean
    done
}


case "$1" in
install)
    shift
    npm_install $*
    ;;
sh)
    shift
    /bin/sh $*
    ;;
*)
    npm_install
    plus.garden $*
    ;;
esac
