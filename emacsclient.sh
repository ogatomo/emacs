#!/bin/sh

# create EmacsClient.app
# 
# platypus -D -y -a EmacsClient -p /bin/sh -o None emacsclient.sh

/usr/local/bin/emacsclient -n "$1"

