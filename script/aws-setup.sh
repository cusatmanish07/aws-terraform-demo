#!/bin/bash

set -x

if [ $# -ne 1 ]; then
    echo "Usage ./$0 create or delete"
    exit 1;
fi

status_check () {
  retval=$?
  message=$1
  if [ $retval -eq 0 ]; then
     echo "${message} Suceesffully"
  else
     echo "${message} Failed"
  fi
}

cleanupArtifacts() {
    bucket_name=$1
    aws s3 rm s3://${bucket_name} --recursive
    status_check "${bucket_name} Cleaned up"
}

createBucket(){
    bucket_name=$1
    region=$2
    aws s3api create-bucket --bucket ${bucket_name} --region ${region} --create-bucket-configuration LocationConstraint=${region}
    status_check "s3 bucket ${bucket_name}"
}

deleteBucket() {
    bucket_name=$1
    aws s3api delete-bucket --bucket ${bucket_name}
    status_check "${bucket_name} deleted"
}

createDynamoDB(){
    table_name=$1
    region=$2
    aws dynamodb create-table --table-name ${table_name} \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --table-class STANDARD \
    --region ${region}
    status_check "Dynamodb Table ${table_name} Created"
}

deleteDynamoDB(){
    table_name=$1
    region=$2
    aws dynamodb delete-table --table-name ${table_name} --region ${region}
    status_check "Dynamodb Table ${table_name} Deleted"
}

action=$1

if [ "$action" == "create" ]; then
    # Create s3 bucket
    createBucket "dev-tfstate-manish1" "us-west-1"
    createBucket "prod-tfstate-manish1" "us-west-2"

    # Create DynamoDB Table
    createDynamoDB dev-tfstate-manish us-west-1
    createDynamoDB prod-tfstate-manish us-west-2 

elif [ "$action" == "delete" ]; then
    # Cleanup all the artifact in s3 buckets before bucket deletion
    s3_bucket_list="dev-tfstate-manish1 prod-tfstate-manish1"
    dynamodDB_list="dev-tfstate-manish:us-west-1 prod-tfstate-manish:us-west-2"

    for i in $s3_bucket_list 
    do
      cleanupArtifacts $i
    done

    # Delete all the s3 buckets created

    for i in $s3_bucket_list
    do
      deleteBucket $i
    done

    # Delete All Dynamodb Table
    for i in $dynamodDB_list
    do
      DB_name=$(echo $i | cut -d':' -f1)
      region_name=$(echo $i | cut -d':' -f2)
      deleteDynamoDB $DB_name $region_name
    done
else
   echo "Please input either create or delete"
fi