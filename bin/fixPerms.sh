#!/bin/bash
# fixPerms.sh
# Recursively chmods directories to 755 and their files to 644

find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
