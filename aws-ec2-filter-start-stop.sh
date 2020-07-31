#!/bin/bash
echo "server_type: $1"
echo "tenant_number1: $2"
echo "tenant_number2: $3"
echo "Servers are" $1-$2 "and" $1-$3 
for instance in $(aws ec2 describe-instances --filters 'Name=tag:Name,Values='$1-$2','$1-$3'' | grep InstanceId | cut -d '"' -f 4 | sort); do
    echo $instance
    aws ec2 describe-instance-attribute --instance-id $instance --attribute disableApiTermination | grep Value | cut -d : -f 2
    #aws ec2 describe-instances --instance-id $instance --query 'Reservations[].Instances[].[State.Name]' --output text
    #aws ec2 describe-instances --instance-id $instance --query 'Reservations[].Instances[].[InstanceId]' --output text
done
exit

# **************************************************************************
# for instance in $(aws ec2 describe-instances --filters 'Name=tag:Name,Values=ppv-stg-tenant2-rdp01-srv,ppv-stg-tenant2-svc01-srv' | grep InstanceId | cut -d '"' -f 4 | sort); do
#     echo -n $instance
#     aws ec2 describe-instance-attribute --instance-id $instance --attribute disableApiTermination | grep Value | cut -d : -f 2
#     aws ec2 describe-instances --instance-id $instance --query 'Reservations[].Instances[].[State.Name]'
# done

# aws ec2 describe-instances --filters Name=tag:Environment,Values=stg-tenant2 --query "Reservations[].Instances[].{Instance:InstanceId,Name:Tags[?Key=='Name']|[0].Value}" --output table
# aws ec2 describe-instances --filters Name=tag:Environment,Values=stg-tenant2 --query 'Reservations[].Instances[].[InstanceId]' --output text
# aws ec2 describe-instances --filters Name=tag:Environment,Values=stg-tenant2 --query "Reservations[].Instances[].{Instance:InstanceId,Name:Tags[?Key=='Name']|[0].Value}" --output table | grep -E "svc|web|mgmt|jenkins|elasticsearch"

# if you run like this :
# Name=tag:Environment,Values=stg-tenant2
# You get 8 instance 
# Out of that, I need 4 instanceid 

# Requirement 
# 8 box name 
# 4 box  = only instance id - stop
# aws ec2 describe-instances --filters 'Name=tag:Name,Values=Webserver-1' | grep InstanceId | cut -d '"' -f 4 | sort
# aws ec2 describe-instance-attribute --instance-id i-0568507be7a8c011b --attribute disableApiTermination | grep Value | cut -d : -f 2