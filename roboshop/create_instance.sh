#!/bin/bash
LID=lt-05397bf2df1fb116f
LVER=2
aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER | jq .Instances[].InstanceId |