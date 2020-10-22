#! /bin/sh

set -e
set -o pipefail



# Environment checks
if [ "${GCLOUD_KEYFILE_BASE64}" = "**None**" ]; then
  echo "You need to set the GCLOUD_KEYFILE_BASE64 environment variable."
  exit 1
fi

if [ "${GCLOUD_PROJECT_ID}" = "**None**" ]; then
  echo "You need to set the GCLOUD_PROJECT_ID environment variable."
  exit 1
fi

if [ "${GCS_BACKUP_BUCKET}" = "**None**" ]; then
  echo "You need to set the GCS_BACKUP_BUCKET environment variable."
  exit 1
fi

# Google Cloud Auth
echo "Authenticating to Google Cloud..."
echo $GCLOUD_KEYFILE_BASE64 | base64 -d > /key.json
gcloud auth activate-service-account --key-file /key.json --project "$GCLOUD_PROJECT_ID" -q

# Upload to GCS
echo "Uploading dump to $GCS_BACKUP_BUCKET..."
gsutil cp $FILENAME $GCS_BACKUP_BUCKET/$FILENAME
