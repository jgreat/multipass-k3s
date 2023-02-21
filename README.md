# multipass-k3s
I think this is the easiest way to get a full function kubernetes cluster on your local machine.  Some super dumb scripts to start and delete.

### Requirements

- [multipass](https://multipass.run/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

### Reference

- [k3s](https://k3s.io/)

### Run

Run will start a new VM in multipass and automatically bootstrap k3s with a `cloud-init.yaml`.

- Customize the `cloud-init.yaml` to make it your own.
- The run script will grab the IP address of the VM and put it in your `/etc/hosts` file so you can reach it as `k3s` or `k3s.multipass`.
- Finally grab the default kubeconfig file out of the vm and save it in your local directory.


```
./run.sh

Launched: k3s
Checking /etc/hosts for k3s entries
No k3s.multipass line found - making one
[sudo] password for jgreat:
```

Wire up the kubeconfig file and try it out.

```bash
export KUBECONFIG=$(pwd)/k3s.yaml
kubectl get nodes

NAME   STATUS   ROLES                  AGE   VERSION
k3s    Ready    control-plane,master   17m   v1.25.6+k3s1

```

### Delete

To delete the vm run:

```
./delete.sh
```
