FROM google/cloud-sdk:alpine

# Install deps
ADD setup.sh setup.sh
RUN sh setup.sh && rm setup.sh

# GCS Environment
ENV GCLOUD_KEYFILE_BASE64 **None**
ENV GCLOUD_PROJECT_ID **None**
ENV GCS_BACKUP_BUCKET **None**

# Backup options
ENV SCHEDULE **None**


ADD run.sh run.sh
ADD backup.sh backup.sh

CMD ["sh", "run.sh"]
