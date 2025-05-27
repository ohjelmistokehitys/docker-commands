#!/bin/bash
#
# This script processes logs from a syslog file, filtering for critical messages.
# The logic for the script is explained in the readme file.
curl https://ohjelmistokehitys.github.io/docker-commands/syslog.txt | grep "CRITICAL" | sort