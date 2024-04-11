#!/bin/bash

raw_download() {
    wPROTO="${1%://*}"
    af="${1#*://}"
    wBASE="${af%%/*}"
    wSUB="${af#*/}"

    HTTP_REQUEST="$({
        echo -en 'GET /'"${wSUB}"' HTTP/1.1\r\n'
        echo -en 'Host: '"${wBASE}"'\r\n'
        echo -en 'Connection: close\r\n\r\n'
    })"

    if [[ "${wPROTO,,}" = 'https' ]] ; then
        echo "${HTTP_REQUEST}" | openssl s_client -quiet -connect ${wBASE}:443
    else
        exec {NFD}<>"/dev/tcp/${wBASE}/80"
        echo "${HTTP_REQUEST}" >&"${NFD}"
        while read -u "${NFD}" lz; do
            echo "${lz}"
        done
        exec {wFD}>&-
    fi
}

main() {
    raw="$(raw_download "${1}" 2>errorlog.txt)"
    echo "${raw#*$'\r\n\r\n'}" > "${2}"
}

main "${@}"