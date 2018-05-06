#!/bin/bash

THIS_DIR=$( (cd "$(dirname -- "$BASH_SOURCE")" && pwd -P) )

set -eux

cd "$THIS_DIR"
vagrant box remove 'file://builds/libvirt-centos7.box' || true
PACKER_LOG=1 packer build --only=qemu centos7.json
vagrant up libvirt --provider=libvirt
