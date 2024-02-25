#! /bin/bash
set -e
if ! az account show; then
    az login --identity
fi

az lock create --name rgLock --resource-group rg-alz-monitor --lock-type ReadOnly
