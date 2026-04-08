import json
import os
from datetime import datetime
from urllib.parse import unquote_plus

import boto3


s3 = boto3.client("s3")

RAW_BUCKET = os.getenv("RAW_BUCKET")
PROCESSED_BUCKET = os.getenv("PROCESSED_BUCKET")


def transform_record(record: dict) -> dict:
    return {
        "user_id": record.get("user_id"),
        "event_type": record.get("event_type"),
        "country": record.get("country"),
        "timestamp": record.get("timestamp"),
        "processed_at": datetime.utcnow().isoformat() + "Z",
        "is_purchase": record.get("event_type") == "purchase",
    }


def handler(event, context):
    results = []

    for s3_record in event.get("Records", []):
        bucket_name = s3_record["s3"]["bucket"]["name"]
        object_key = unquote_plus(s3_record["s3"]["object"]["key"])

        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        content = response["Body"].read().decode("utf-8")
        records = json.loads(content)

        transformed = [transform_record(record) for record in records]

        output_key = f"processed/{object_key.split('/')[-1]}"

        s3.put_object(
            Bucket=PROCESSED_BUCKET,
            Key=output_key,
            Body=json.dumps(transformed, indent=2).encode("utf-8"),
            ContentType="application/json",
        )

        results.append(
            {
                "source_bucket": bucket_name,
                "source_key": object_key,
                "target_bucket": PROCESSED_BUCKET,
                "target_key": output_key,
                "records_processed": len(transformed),
            }
        )

    return {
        "statusCode": 200,
        "body": json.dumps(
            {
                "message": "Processing completed successfully",
                "results": results,
            }
        ),
    }