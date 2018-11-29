#!/bin/bash

THIS_DIR=$( (cd "$(dirname -- "$BASH_SOURCE")" && pwd -P) )

set -eux

cd "$THIS_DIR"
vagrant box remove 'file://builds/libvirt-centos7.box' || true
if type packer.io &> /dev/null; then
    PACKER=packer.io
else
    PACKER=packer
fi

PACKER_LOG=1 $PACKER build --only=qemu centos7.json
vagrant up libvirt --provider=libvirt
