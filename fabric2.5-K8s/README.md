# Files for building network on local server using kubernetes


# KBA_CHFV2_5


# Now we are going to create a kubernetes cluster with 1 Master and 3 workers

### Obtain the Public IP Address each of the Four machines and SSH log in to each of the machines:

### Open 4 terminals

terminal 1
```
$ ssh fabric@192.168.3.
$ sudo apt update
$ sudo apt upgrade -y
```
terminal 2
```
$ ssh fabric@192.168.3.91
$ sudo apt update
$ sudo apt upgrade -y
```

terminal 3
```
$ ssh fabric@192.168.3.92
$ sudo apt update
$ sudo apt upgrade -y
```

terminal 4
```
$ ssh fabric@192.168.3.89
$ sudo apt update
$ sudo apt upgrade -y
```

### Now reboot all the machines

terminal 1

`$ sudo reboot`

terminal 2

`$ sudo reboot`

terminal 3

`$ sudo reboot`
terminal 4

`$ sudo reboot`

### Now again SSH log in to each of the machines

terminal 1

`$ ssh fabric@192.168.3.90`

terminal 2

`$ ssh fabric@192.168.3.91`

terminal 3

`$ ssh fabric@192.168.3.92`

terminal 4

`$ ssh fabric@192.168.3.89`



### we should change the hostnames of the instances so that we should know which one is master and which one is the worker. let’s start with the master node.

terminal 1 as an master fabric@192.168.3.90 

`$ sudo hostnamectl set-hostname "k8s-master.nvtienanh.local"`

On Worker1 fabric@192.168.3.91

`$ sudo hostnamectl set-hostname "k8s-worker1.nvtienanh.local"`

On Worker2 fabric@192.168.3.92

`$ sudo hostnamectl set-hostname "k8s-worker2.nvtienanh.local"`

On Worker3 fabric@192.168.3.89

`$ sudo hostnamectl set-hostname "k8s-worker3.nvtienanh.local"`


### Install nano editor for all nodes

`sudo apt install nano`

### For all the nodes we need to paste host ip and hostnames

Terminal 1

`$ sudo nano /etc/hosts`

### Inside the /etc/host copy and paste all the host ip and hostnames
```
192.168.3.90  k8s-master.nvtienanh.local k8s-master
192.168.3.91  k8s-worker1.nvtienanh.local k8s-worker1
192.168.3.92  k8s-worker2.nvtienanh.local k8s-worker2
192.168.3.89  k8s-worker3.nvtienanh.local k8s-worker3
```

Terminal 2

`$ sudo nano /etc/hosts`

### Inside the /etc/host copy and paste all the host ip and hostnames
```
192.168.3.90  k8s-master.nvtienanh.local k8s-master
192.168.3.91  k8s-worker1.nvtienanh.local k8s-worker1
192.168.3.92  k8s-worker2.nvtienanh.local k8s-worker2
192.168.3.89  k8s-worker3.nvtienanh.local k8s-worker3
```

Terminal 3

`$ sudo nano /etc/hosts`

### Inside the /etc/host copy and paste all the host ip and hostnames
```
192.168.3.90  k8s-master.nvtienanh.local k8s-master
192.168.3.91  k8s-worker1.nvtienanh.local k8s-worker1
192.168.3.92  k8s-worker2.nvtienanh.local k8s-worker2
192.168.3.89  k8s-worker3.nvtienanh.local k8s-worker3
```

Terminal 4

`$ sudo nano /etc/hosts`
### Inside the /etc/host copy and paste all the host ip and hostnames
```
192.168.3.90  k8s-master.nvtienanh.local k8s-master
192.168.3.91  k8s-worker1.nvtienanh.local k8s-worker1
192.168.3.92  k8s-worker2.nvtienanh.local k8s-worker2
192.168.3.89  k8s-worker3.nvtienanh.local k8s-worker3
```

For all the node

### Now disable Linux swap space permanently in /etc/fstab. Search for a swap line and add (hashtag sign in front of the line.

Terminal 1
```
$ sudo swapoff -a
$ free -h
```

Comment out swap line

``` bash
$ sudo vim /etc/fstab
#/swap.img	none	swap	sw	0	0
```

Terminal 2
```
$ sudo swapoff -a
$ free -h
```

Comment out swap line

``` bash
$ sudo vim /etc/fstab
#/swap.img	none	swap	sw	0	0
```

Terminal 3
```
$ sudo swapoff -a
$ free -h
```

Comment out swap line

``` bash
$ sudo vim /etc/fstab
#/swap.img	none	swap	sw	0	0
```

Terminal 4
```
$ sudo swapoff -a
$ free -h
```

Comment out swap line

``` bash
$ sudo vim /etc/fstab
# /swap.img	none	swap	sw	0	0
```

Confirm setting is correct

Terminal 1
```
$ sudo mount -a
$ free -h
```

Terminal 2
```
$ sudo mount -a
$ free -h
```

Terminal 3
```
$ sudo mount -a
$ free -h
```

Terminal 4
```
$ sudo mount -a
$ free -h
```

### Enable kernel modules and configure sysctl.

Terminal 1
```
$ sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF


$ sudo modprobe overlay
$ sudo modprobe br_netfilter

$ sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


$ sudo sysctl --system
```


Terminal 2
```
$ sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF


$ sudo modprobe overlay
$ sudo modprobe br_netfilter

$ sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


$ sudo sysctl --system
```

Terminal 3
```
$ sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF


$ sudo modprobe overlay
$ sudo modprobe br_netfilter

$ sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


$ sudo sysctl --system
```

Terminal 4
```
$ sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF


$ sudo modprobe overlay
$ sudo modprobe br_netfilter

$ sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


$ sudo sysctl --system
```


### : Install Container runtime

To run containers in Pods, Kubernetes uses a container runtime. Supported container runtimes are:

- Docker
- CRI-O
- Containerd

For all the terminals

```
$ sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

$ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg


$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

$ sudo apt update
$ sudo apt install -y containerd.io


$ containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1


$ sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml


$ sudo systemctl restart containerd
$ sudo systemctl enable containerd

$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

$ sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

```


### Download kubelet kubeadm kubectl

for all the nodes

```
$ sudo apt update

$ sudo apt install -y kubelet kubeadm kubectl

$ sudo apt-mark hold kubelet kubeadm kubectl

$ sudo kubeadm reset


```

### Run On Master node only Terminal 1 is our master node

```
$ sudo kubeadm init \
  --pod-network-cidr=10.10.0.0/16 \
  --control-plane-endpoint=k8s-master.nvtienanh.local
```

Till here f you did everything correctly, you should see the following screen

At this point note down the last part of the output that includes the `kubeadm join `  with this command we will have to join others workers nodes

Now, we need to run the following commands to set up local `kubeconfig` on master node.

```
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

$ kubectl cluster-info
$ kubectl get nodes
```

### Now Joining Workers nodes

you can see after the kubeadm init you would get the kubeadm join -token=<TOKEN> and <IP ADDRESS OF THE MASTER NODE>

copy and paste for all the workers nodes

Terminal 2
```
kubeadm join -token=<token> <IP Address of the master node>
```

Terminal 3
```
kubeadm join -token=<token> <IP Address of the master node>
```
Terminal 4
```
kubeadm join -token=<token> <IP Address of the master node>
```

# For Only worker node terminal 1

### Now Download the Calico networking manifest for the Kubernetes API datastore.

```
curl https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml -O  
```

### Now Open downloaded file to update pod classless

`$ sudo nano calico.yaml`


What we need to do here inside the file find CALICO_IPV4POOL_CIDR and uncomment this text

```
 - name: CALICO_IPV4POOL_CIDR
              value: "10.10.0.0/16"
```

Run these command in master node

```
$ kubectl apply -f calico.yaml 
$ kubectl get pods -n kube-system
```

### End part is how to access kubernetes cluster on local machine 

Run these command on local machine

You need to first copy some Kubernetes credentials from remote Kubernetes master to your local machine.

`$ scp -r fabric@192.168.3.90:/home/fabric/.kube .`

Copy Kubernetes Credentials To Your Home

`$ cp -r .kube $HOME/`

