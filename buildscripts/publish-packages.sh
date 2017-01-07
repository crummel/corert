#!/usr/bin/env bash

# don't pass args to buildvars-setup, just get defaults
scriptRoot="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. $scriptRoot/buildvars-setup.sh

export AzureAccount=
export AzureToken=
export Container=

while [ "$1" != "" ]; do
        lowerI="$(echo $1 | awk '{print tolower($0)}')"
        case $lowerI in
        -azureaccount)
            shift
            echo "account: $1"
            export AzureAccount=$1
            ;;
        -azuretoken)
            shift
            echo "token: $1"
            export AzureToken=$1
            ;;
        -container)
            shift
            echo "container: $1"
            export Container=$1
            ;;
        *)
          echo Bad argument $1
          exit 1
    esac
    shift
done

echo "$__ProjectRoot/Tools/msbuild.sh $scriptRoot/publish.proj /p:CloudDropAccountName=$AzureAccount /p:CloudDropAccessToken=$AzureToken /p:ContainerName=$Container"
$__ProjectRoot/Tools/msbuild.sh $scriptRoot/publish.proj /p:CloudDropAccountName=$AzureAccount /p:CloudDropAccessToken=$AzureToken /p:ContainerName=$Container "/flp:v=diag;LogFile=publish-packages.log"