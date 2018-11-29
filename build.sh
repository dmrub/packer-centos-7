#!/bin/bash

THIS_DIR=$( (cd "$(dirname -- "$BASH_SOURCE")" && pwd -P) )

set -eux

cd "$THIS_DIR"
vagrant box remove 'file://builds/virtualbox-centos7.box' || true
if type packer.io &> /dev/null; then
    PACKER=packer.io
else
    PACKER=packer
fi
$PACKER build --only=virtualbox-iso centos7.json
vagrant up virtualbox --provider=virtualbox
