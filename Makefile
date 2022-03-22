vmname ?= simplevm
vmnet ?= testnet
vmpool ?= pool01
vmpooldir ?= /data/libvirtpool/terraform-provider-libvirt-pool-debian
libvirturi ?= qemu:///system

cleanall:
	terraform destroy -auto-approve || exit 0
	virsh -c ${libvirturi} destroy ${vmname} || exit 0
	virsh -c ${libvirturi} undefine ${vmname} || exit 0
	virsh -c ${libvirturi} net-destroy ${vmnet} || exit 0
	virsh -c ${libvirturi} net-undefine ${vmnet} || exit 0
	virsh -c ${libvirturi} pool-destroy ${vmpool} || exit 0
	virsh -c ${libvirturi} pool-undefine ${vmpool} || exit 0
	sudo rm -rf ${vmpooldir}  || exit 0
	sudo rm -rf ./terraform.tfstate* || exit 0

apply:
	terraform init
	terraform plan
	TF_LOG=INFO terraform apply -auto-approve

recreate: cleanall apply

play-app:
	ansible-playbook -v -D -i ansible_inventory.ini provision/play_app.yml

play-provision:
	ansible-playbook -v -D -i ansible_inventory.ini provision/play_provision.yml

test:
	curl http://$$(cat ansible_inventory.ini | grep "${vmname}" | cut -f2 -d '=' | cut -f1 -d ' ')
