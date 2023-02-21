#!/bin/bash

set -e

multipass launch -n k3s -m 8G -c 8 -d 20G --cloud-init ./cloud-init.yaml

ip=$(multipass info k3s --format json | jq -r '.info.k3s.ipv4[0]')

echo "Checking /etc/hosts for k3s entries."
if grep -qE "k3s k3s.multipass" /etc/hosts
then
    echo "Found a k3s.multipass line, replace with current."
    sudo sed -i'' "s/.*k3s k3s.multipass.*/${ip} k3s k3s.multipass/g" /etc/hosts
else
    echo "No k3s.multipass line found - making one."
    echo "${ip} k3s k3s.multipass" | sudo tee -a /etc/hosts
fi

# multipass mount -g 1000:1000 -u 1000:1000 "${HOME}/git" k3s:/home/ubuntu/git

while ! multipass exec k3s -- test -f /etc/rancher/k3s/k3s.yaml
do
    sleep 5
done

./get-kubeconfig.sh
