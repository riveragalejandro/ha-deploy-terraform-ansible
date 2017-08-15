#!/bin/bash

if [ $# -ne 1 ]; then
	echo Usage: $0 environment
	echo e.g.: $0 dev
	exit 1
fi


ansible-playbook notejam-"$1".yml -i inventory/ec2.py --key-file ../terraform/modules/ec2/keys/"$1".pem -u ec2-user
