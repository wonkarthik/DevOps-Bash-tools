#!/usr/bin/env bash
#  shellcheck disable=SC2154
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: circa 2006 - 2012 (forked from .bashrc)
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
#                            P r o m p t   M a g i c
# ============================================================================ #

# XXX: Warning: imperfect PS1 prompt codes cause terminal to not move to the newline properly but instead wrap around on the same line

# \[\033k\033\\\] is required for Screen auto title feature to detect prompt
# replace \033 with \e as it's directly supported in PS1

# need 'Defaults env_keep=STY' for this to not trigger on sudo su
SCREEN_ESCAPE="\[\ek\e\\\\\]"

PS1=""

# if inside Screen, set the screen escape inside PS1
[ -n "$STY" ] && PS1="$SCREEN_ESCAPE"

PS1_COLOUR="$txtgrn"

if [ $EUID -eq 0 ]; then
    PS1_COLOUR="$txtred"
fi

# XXX: important that every single escape sequence is enclosed in \[ \] to make sure it isn't included in the line wrapping calculcation otherwise the lines wrap back on to themselves
#   \W      basename of cwd
#   \w      full path of cwd
#   \h      host
export PS1+="\[$PS1_COLOUR\]\t \[$bldblu\]\w \[$PS1_COLOUR\]> \[$txtrst\]"


# Screen relies on prompt having a dollar sign to detect the next word to set the screen title dynamically - .screenrc needs the following setting
#
# shelltitle ' > |'

# TODO: make screen auto title detect # for root


# For passing PS1 around:
#
#   base64 <<< "$PS1" 
#
# and then pass the result through base64 -d
#
#   base64 <<< "$PS1" | base64 -d
#
# is a noop to demonstrate


export PS4="--> "
# Bash performance profiling, can be heavy on performance, &>/tmp/bash.out then use profiling script
#export PS4='$(date "+%s.%N ($LINENO) + ") --> '