#!/bin/bash

set -eux

# Install VirtualBox tools
if [[ -f ~vagrant/.vbox_version ]]; then
    VBOX_VERSION=$(< ~vagrant/.vbox_version)

    tmpdir=
    cleanup() {
        if [[ -d "$tmpdir" ]]; then
            umount "$tmpdir" || true;
            rm -rf "$tmpdir";
        fi
    }
    tmpdir=$(mktemp -d)
    trap cleanup INT TERM EXIT
    mount -t iso9660 -o loop ~vagrant/VBoxGuestAdditions_${VBOX_VERSION}.iso "$tmpdir"
    "$tmpdir/VBoxLinuxAdditions.run"
    cleanup
    rm ~vagrant/VBoxGuestAdditions_${VBOX_VERSION}.iso
fi

# Installing vagrant keys
mkdir ~vagrant/.ssh
chmod 700 ~vagrant/.ssh
cd ~vagrant/.ssh
if type wget &> /dev/null; then
    wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
else
    curl -kLf 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -o authorized_keys
fi
chmod 600 ~vagrant/.ssh/authorized_keys
chown -R vagrant ~vagrant/.ssh

echo "Vagrant insecure keys installed"
