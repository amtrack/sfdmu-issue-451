#!/usr/bin/env bash

set -eo pipefail

set -x

sfdx force:org:create -f config/project-scratch-def.json -a sfdmu -s
