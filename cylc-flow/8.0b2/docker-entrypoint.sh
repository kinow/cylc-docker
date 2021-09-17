#!/bin/bash

set -e

if [ -z "$1" ]
then
    exec "/bin/bash"
else
    exec "$1"
fi
