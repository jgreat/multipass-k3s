#!/bin/bash

multipass exec k3s sudo cat /etc/rancher/k3s/k3s.yaml > ./k3s.yaml

sed -i -e 's/127.0.0.1/k3s.multipass/g' ./k3s.yaml
sed -i -e 's/default/k3s.multipass/g' ./k3s.yaml
