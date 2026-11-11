import json
import logging
import os

import boto3
from botocore.exceptions import ClientError


logger = logging.getLogger()
logger.setLevel(logging.INFO)

ec2 = boto3.client("ec2")

TAG_KEY = os.environ.get("TAG_KEY", "AutoSchedule")
TAG_VALUE = os.environ.get("TAG_VALUE", "true")
ENVIRONMENT = os.environ.get("ENVIRONMENT", "development")


def get_instances(action):
    if action == "start":
        required_state = "stopped"
    else:
        required_state = "running"

    response = ec2.describe_instances(
        Filters=[
            {
                "Name": f"tag:{TAG_KEY}",
                "Values": [TAG_VALUE]
            },
            {
                "Name": "tag:Environment",
                "Values": [ENVIRONMENT]
            },
            {
                "Name": "instance-state-name",
                "Values": [required_state]
            }
        ]
    )

    instance_ids = []

    for reservation in response["Reservations"]:
        for instance in reservation["Instances"]:
            instance_ids.append(instance["InstanceId"])

    return instance_ids


def lambda_handler(event, context):
    logger.info(
        json.dumps({
            "message": "Scheduler invocation started",
            "request_id": context.aws_request_id,
            "event": event
        })
    )

    action = event.get("action")

    if action not in ["start", "stop"]:
        logger.error("Invalid or missing action")

        return {
            "statusCode": 400,
            "body": json.dumps({
                "error": "action must be start or stop"
            })
        }

    try:
        instance_ids = get_instances(action)

        if not instance_ids:
            logger.info(
                f"No eligible instances found for action: {action}"
            )

            return {
                "statusCode": 200,
                "body": json.dumps({
                    "action": action,
                    "instances": [],
                    "message": "No eligible instances found"
                })
            }

        if action == "start":
            ec2.start_instances(InstanceIds=instance_ids)
        else:
            ec2.stop_instances(InstanceIds=instance_ids)

        logger.info(
            json.dumps({
                "message": "EC2 action submitted",
                "action": action,
                "instances": instance_ids
            })
        )

        return {
            "statusCode": 200,
            "body": json.dumps({
                "action": action,
                "instances": instance_ids,
                "message": "Action submitted successfully"
            })
        }

    except ClientError as error:
        logger.exception("AWS API request failed")

        return {
            "statusCode": 500,
            "body": json.dumps({
                "error": str(error)
            })
        }