import boto3
from botocore.exceptions import ClientError
from flask import Flask, jsonify
app = Flask(__name__)

# Replace with your bucket name
BUCKET_NAME = "http-s3-bucket"

# Initialize S3 client
s3_client = boto3.client('s3')

@app.route('/list-bucket-content', defaults={'path': ''}, methods=['GET'])
@app.route('/list-bucket-content/<path:path>', methods=['GET'])
def list_bucket_content(path):
    try:
        # Add a trailing slash to the prefix if not empty
        prefix = f"{path.rstrip('/')}/" if path else ""

        # List objects in the bucket
        response = s3_client.list_objects_v2(Bucket=BUCKET_NAME, Prefix=prefix, Delimiter='/')

        # Collect directories and files
        content = []
        if 'CommonPrefixes' in response:
            content.extend([prefix['Prefix'].rstrip('/').split('/')[-1] for prefix in response['CommonPrefixes']])
        if 'Contents' in response:
            content.extend([obj['Key'].split('/')[-1] for obj in response['Contents'] if obj['Key'] != prefix])

        return jsonify({"content": content}), 200

    except ClientError as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
