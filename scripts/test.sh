#!/usr/bin/env bash

set -eo pipefail

_clean() {
    sfdx force:apex:execute -f scripts/clean.apex
}

_setup() {
    sfdx force:apex:execute -f scripts/setup.apex
}


# finally clean up
trap _clean EXIT

_clean
_setup
sfdx sfdmu:run -p data -s sfdmu -u csvfile --verbose

_clean
sfdx sfdmu:run -p data -s csvfile -u sfdmu --verbose

accounts="$(node -pe 'JSON.parse(fs.readFileSync(0, "utf8")).result.records[0].expr0' < <(sfdx force:data:soql:query -q "SELECT COUNT(Id) FROM Account WHERE Name LIKE 'Test SFDMU%'" --json))"
if [[ "$accounts" != "1" ]]; then
    echo "ERROR: expected 1 account but got ${accounts}"
    exit 1;
fi

opportunities="$(node -pe 'JSON.parse(fs.readFileSync(0, "utf8")).result.records[0].expr0' < <(sfdx force:data:soql:query -q "SELECT COUNT(Id) FROM Opportunity WHERE Name LIKE 'Test SFDMU%'" --json))"
if [[ "$opportunities" != "2" ]]; then
    echo "ERROR: expected 2 opportunity but got ${opportunities}"
    exit 1;
fi
