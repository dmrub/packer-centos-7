#!/bin/bash

THIS_DIR=$( (cd "$(dirname -- "$BASH_SOURCE")" && pwd -P) )

set -eux

cd "$THIS_DIR"
vagrant box remove 'file://builds/virtualbox-centos7.box' || true
packer build --only=virtualbox-iso centos7.json
vagrant up virtualbox --provider=virtualbox
