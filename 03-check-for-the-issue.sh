#! /bin/bash

# First, kill existing instances of collectd
# This needs manual intervention, to keep things simple.
# Display a list of processes that match "collectd", and prompt the user to enter one or more PIDs to kill
ps aux | grep collectd
echo 'Select pid(s) to kill and hit "Enter"'
read PIDs
kill $PIDs

#. create-tiny-test-vm.sh

# Start collectd, assuming that collectd is installed via RPM, and in PATH
collectd -f -C collectd.conf.use | grep "virt plugin: Array index out of bounds: tag_index"

#. destroy-tiny-test-vm.sh
