# Test Terraform / Ansible repo (libvirt)

- provision a vm (80 / 22 tcp port allow only)
- generate ansible inventory
- install nginx + custom index file
- libvirt (qemu) is my provisioner and we use [dmacvicar/libvirt ](https://github.com/dmacvicar/terraform-provider-libvirt) terraform provider
- terraform files are 

# Requirements

- on Debian host, follow [instructions](https://wiki.debian.org/KVM)
- Make sure to have access to virsh cli (virsh --connect qemu:///system list)
- git clone this repo
- need python/pip, terraform, Makefile

```
# to install ansible
$ pip install -r requirements.txt

```

- Be sure to generate a personal ssh key pair

- Don't forget to customize variables.tf

# Test

- provision:

```
$ make apply
# or
$ terraform init
$ terraform plan
$ terraform apply

```

- Verify ansible inventory file (./ansible_inventory.ini)
  
- deploy nginx and index.html

```
$ make play-app
# or
$ ansible-playbook -v -D -i ansible_inventory.ini provision/play_app.yml
# ####
# make test
# or
# curl http://iventoryipvm
```

- cleanup
  
```
# will terraform destroy and remove libvirt files
$ make cleanall
# or
$ terraform destroy

```
