#copy the id_rsa file to the .ssh folder of the home directory
#copy the requirements.txt file to the home directory
#copy the k8s-inventory.ini to the home directory
echo $(date) " - Starting basic package installation"
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install software-properties-common -y
sudo apt-get install ansible -y
sudo apt-get install git -y
sudo apt-get install python-pip -y
sudo apt-get install unzip -y
sudo wget https://github.com/kubernetes-sigs/kubespray/archive/master.zip
sudo unzip master.zip
sudo rm -rf master.zip
sudo mv kubespray-master/ kubespray
sudo pip install -r requirements.txt
sudo cp k8s-inventory.ini kubespray/k8s-inventory.ini
sudo chmod 400 id_rsa
cd kubespray
export ANSIBLE_HOST_KEY_CHECKING=False
sudo ansible all -i k8s-inventory.ini --become -u=k8s-admin --private-key=/home/k8s-admin/id_rsa -m ping
sudo ansible all -i k8s-inventory.ini --become -u=k8s-admin --private-key=/home/k8s-admin/id_rsa -m shell -a 'sudo sysctl -w net.ipv4.ip_forward=1'
sudo ansible-playbook -i k8s-inventory.ini --become -u=k8s-admin --private-key=/home/k8s-admin/id_rsa cluster.yml