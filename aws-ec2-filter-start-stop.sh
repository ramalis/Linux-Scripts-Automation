#Disable-Termination-Protection
#!/bin/bash
aws s3 ls --profile test | grep cf
export AWS_DEFAULT_PROFILE=test
clear
echo "enter the server_name"
read server_name
echo "enter first tenant_number"
read tenant_number1
echo "enter second tenant_number"
read tenant_number2
for instance in $(aws ec2 describe-instances --filters 'Name=tag:Name,Values='$server_name-$tenant_number1','$server_name-$tenant_number2'' | grep InstanceId | cut -d '"' -f 4 | sort); do 
    echo $instance
    aws ec2 describe-instance-attribute --instance-id $instance --attribute disableApiTermination | grep Value | cut -d : -f 2
    aws ec2 modify-instance-attribute --no-disable-api-termination --instance-id $instance | grep Value | cut -d : -f 2
    # aws ec2 describe-instances --instance-id $instance --query 'Reservations[].Instances[].[State.Name]' --output table
done
echo "Termination protection is successfully disabled"
