#!/bin/bash

if [ -z ${PLUGIN_BUCKET} ]; then
  echo "missing S3 Bucket"
  exit 1
fi

if [ -z ${PLUGIN_REGION} ]; then
  PLUGIN_REGION="us-east-1"
fi

if [ -z ${PLUGIN_TARGET} ]; then
  PLUGIN_TARGET="/"
fi

if [ -z "${PLUGIN_SOURCE}" ]; then
  SOURCE="./"
else
  SOURCE=$PLUGIN_SOURCE
fi

if [ -z "${PLUGIN_EXCLUDE}" ]; then
  EXCLUDE=""
else
  EXCLUDE="--exclude '$PLUGIN_EXCLUDE'"
fi

if [ -z "${PLUGIN_INCLUDE}" ]; then
  INCLUDE=""
else
  INCLUDE="--include '$PLUGIN_INCLUDE'"
fi

if [ -z "${PLUGIN_ACL}" ]; then
  ACL=""
else
  ACL="--acl '$PLUGIN_ACL'"
fi

if [ ${PLUGIN_DELETE} == true ]; then
  PLUGIN_DELETE="--delete"
else
  PLUGIN_DELETE=""
fi

if [ ! -z ${PLUGIN_AWS_ACCESS_KEY_ID} ]; then
  AWS_ACCESS_KEY_ID=$PLUGIN_AWS_ACCESS_KEY_ID
fi

if [ ! -z ${PLUGIN_AWS_SECRET_ACCESS_KEY} ]; then
  AWS_SECRET_ACCESS_KEY=$PLUGIN_AWS_SECRET_ACCESS_KEY
fi

echo "aws s3 sync --region $PLUGIN_REGION $PLUGIN_DELETE $EXCLUDE $INCLUDE $ACL $SOURCE s3://$PLUGIN_BUCKET$PLUGIN_TARGET"

aws s3 sync --region ${PLUGIN_REGION} ${PLUGIN_DELETE} ${EXCLUDE} ${ACL} ${INCLUDE} ${SOURCE} s3://${PLUGIN_BUCKET}${PLUGIN_TARGET}


if [ -n "$PLUGIN_CLOUDFRONT_DISTRIBUTION_ID" ]; then
  aws cloudfront create-invalidation --region $PLUGIN_REGION --distribution-id $PLUGIN_CLOUDFRONT_DISTRIBUTION_ID --paths /*
fi

