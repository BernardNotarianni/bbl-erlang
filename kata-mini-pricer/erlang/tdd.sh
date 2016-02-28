#!/bin/bash

function ctrl_c {
    echo "** Trapped CTRL-C"
    exit
}

trap ctrl_c INT TERM EXIT

while true; do

    ./rebar eunit skip_deps=true
    echo ""
    # Wait for CRUD of files
    # (do not consider temporary files created by emacs and gedit)
    inotifywait -qr -e modify -e create -e move -e delete src test --exclude "\.\#.*" --exclude "\.goutputstream\-.*"
done
