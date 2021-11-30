#! /bin/bash

yum install -y libvirt libvirt-devel libguestfs-tools-c virt-install
service libvirtd start

mkdir -p /opt/vms/

#vi /etc/libvirt/libvirtd.conf
LIBGUESTFS_BACKEND=direct virt-builder cirros-0.3.5 -o /opt/vms/virt-test.qcow2 --format qcow2 --size 200M --root-password password:tester

# Need to  make sure the appropriate user can launch VMs
#vi /etc/libvirt/qemu.conf
#service libvirtd restart

virt-install --name test_collectd_virt --memory 128 --os-variant cirros0.3.5 --disk path=/opt/vms/virt-test.qcow2 --vcpus 4 --nographics --import --noautoconsole -w network=default

