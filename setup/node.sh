#To deactivate a swap space, use the command swapoff

swapoff -a

#Ubuntu 16.04 has reported issues with traffic being routed incorrectly due to iptables being bypassed. 
#Ensure net.bridge.bridge-nf-call-iptables is set to 1 in the sysctl config,

cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

#Installation Of Docker

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 
 sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

# Dependecy for kubernetes

apt-get install -y apt-transport-https curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

#Installation of Kubelet Kubeadam kubctl

apt-get update -y

apt-get install -y kubelet kubeadm kubectl

systemctl enable kubelet

systemctl start kubelet

kubeadm init --pod-network-cidr=192.168.0.0/16 /// range of Ip to be given

mkdir -p $HOME/.kube 

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config
