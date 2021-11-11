#!/bin/bash
env > .envrc
echo CMD="/root/rtm-gui/raptoreum-qt" >> .envrc

. /entrypoint.sh
