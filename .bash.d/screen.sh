#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: circa 2006-2012 (forked from .bashrc)
#
#  https://github.com/harisekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# ============================================================================ #
#                                  S c r e e n
# ============================================================================ #

sc(){
    checkprog screen || return 1
    isscreen && { echo "I am already in a screen, aborting"; return 1; }
    screen -wipe
    screen -aARRD "$@"
}

screencmd(){
    screen -X "$@"
}

screensleep(){
    screen "$@"
   sleep 0.1
}

alias scnum="screen -X number"

screenbuf(){
    local tmp
    tmp="$(mktemp /tmp/screen-exchange.XXXXXX)"
    cat > "$tmp"
    screen -X readbuf "$tmp"
    rm "$tmp";
}
alias sb=screenbuf

sh_server_real(){
    for x in "$@"; do
        echo "sh server real $x | i $x|Weight|Total"
    done |
    tee /dev/stderr |
    screenbuf
    echo
}
alias fsr=sh_server_real
alias ssr=sh_server_real
