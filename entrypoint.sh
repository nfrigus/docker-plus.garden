#!/bin/sh


LOCK=/var/run/npm-install.pid
NPM_INSTALL_RETRIES=${NPM_INSTALL_RETRIES:-2}


is_npm_ok () {
    if [ `npm list 2>&1 >/dev/null | awk '/^npm (ERR|WARN)/' | grep -v 'npm ERR! extraneous:' | wc -l` = 0 ]
    then return 0
    else return 1
    fi
}

npm_install () {
    local retry_limit=$NPM_INSTALL_RETRIES

    until is_npm_ok; do
        [ $retry_limit -ne $NPM_INSTALL_RETRIES ] && rm -rf node_modules

        npm install

        if [ $((retry_limit--)) = 0 ]; then
            echo 'Npm install failed' >&2
            exit 1
        fi
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
