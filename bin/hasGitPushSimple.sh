#!/bin/bash
# Bradford Smith
# hasGitPushSimple.sh
# updated: 11/05/2015
#####################
# The option "git push.default = simple" was introduced in version 1.7.11


GITVERSION="$(git --version | awk '{print $3}')"
MAJOR="$(echo "${GITVERSION}" | awk -F'.' '{print $1}')"
MINOR="$(echo "${GITVERSION}" | awk -F'.' '{print $2}')"
UPDATE="$(echo "${GITVERSION}" | awk -F'.' '{print $3}')"

HASGITPUSHSIMPLE=0
if [ ${MAJOR} -gt 1 ]; then
    HASGITPUSHSIMPLE=1
elif [ ${MAJOR} -eq 1 ]; then
    if [ ${MINOR} -gt 7 ]; then
        HASGITPUSHSIMPLE=1
    elif [ ${MINOR} -eq 7 ]; then
        if [ ${UPDATE} -gt 11 ]; then
            HASGITPUSHSIMPLE=1
        elif [ ${UPDATE} -eq 11 ]; then
            HASGITPUSHSIMPLE=1
        else
            HASGITPUSHSIMPLE=0
        fi
    else
        HASGITPUSHSIMPLE=0
    fi
else
    HASGITPUSHSIMPLE=0
fi

if [ ${HASGITPUSHSIMPLE} -eq 1 ]; then
    sed --follow-symlinks -i -e "s/<push> #push_default$/simple #push_default/g" ~/.gitconfig
else #upstream is next best thing to simple
    sed --follow-symlinks -i -e "s/<push> #push_default$/upstream #push_default/g" ~/.gitconfig
fi
