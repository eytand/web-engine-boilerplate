#!/bin/sh

set -x

_init () {
    resource="http://localhost:3000/healthcheck"
    start=$(stat -c "%Y" /proc/1)
}

healthcheck_main () {

    if [ $(( $(date +%s) - start )) -lt 60 ]; then
        exit 0
    else
        # Get the http response code
        http_response=$(curl -s -k -o /dev/null -w "%{http_code}" ${resource})

        # Get the http response body
        http_response_body=$(curl -k -s ${resource})

        # server returns response 403 and body "SSL required" if non-TLS
        # connection is attempted on a TLS-configured server. Change
        # the scheme and try again
        if [ "$http_response" = "403" ] && \
        [ "$http_response_body" = "SSL required" ]; then
            scheme="https://"
            http_response=$(curl -s -k -o /dev/null -w "%{http_code}" ${scheme}${address}${resource})
        fi

        # If http_response is 200 - server is up.
        [ "$http_response" = "200" ]
    fi
}

_init && healthcheck_main