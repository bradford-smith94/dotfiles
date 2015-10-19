#!/bin/bash
# Bradford Smith
# hasGitPushSimple.sh
# updated: 10/19/2015
#####################
# The option "git push.default = simple" was introduced in version 1.7.11


GITVERSION="$(git --version | awk '{print $3}')"
MAJOR="$(echo "${GITVERSION}" | awk -F'.' '{print $1}')"
MINOR="$(echo "${GITVERSION}" | awk -F'.' '{print $2}')"
UPDATE="$(echo "${GITVERSION}" | awk -F'.' '{print $3}')"

HASGITPUSHSIMPLE=0

if [ ${MAJOR} -le 1 ]; then
    if [ ${MINOR} -le 7 ]; then
        if [ ${UPDATE} -le 10]; then
            HASGITPUSHSIMPLE=0
        else
            HASGITPUSHSIMPLE=1
        fi
    else
        HASGITPUSHSIMPLE=1
    fi
else
    HASGITPUSHSIMPLE=1
fi

if [ ${HASGITPUSHSIMPLE} ]; then
    sed --follow-symlinks -i -e "s/push_default/simple/g" ~/.gitconfig
else
    sed --follow-symlinks -i -e "s/push_default/upstream/g" ~/.gitconfig
fi
