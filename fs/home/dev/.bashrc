#!/bin/bash
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# so as not to be disturbed by Ctrl-S Ctrl-Q in terminals:
stty -ixon
