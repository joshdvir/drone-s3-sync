# Drone S3 Sync

Use the S3 sync plugin to synchronize files and folders with an Amazon S3 bucket. The following parameters are used to configure this plugin:

* `aws_access_key_id` - amazon key
* `aws_secret_access_key` - amazon secret key
* `bucket` - bucket name
* `region` - bucket region. (defaults to `us-east-1`)
* `acl`    - Sets the ACL for the object when the command is performed. (optional, eg. private, public-read, public-read-write, authenticated-read, aws-exec-read, bucket-owner-read, bucket-owner-full-control and log-delivery-write.)
* `source` - location of folder to sync. (optional, defaults to `./`)
* `target` - target folder in your S3 bucket. (optional, defaults to `/`)
* `exclude`- exclude all files or objects from the command that matches the specified pattern. (optional)
* `include`- don't exclude files or objects in the command that match the specified pattern. (optional)
* `delete` - deletes files in the target not found in the source (optional, defaults to `false`)
* `cloudfront_distribution_id` - (optional) the cloudfront distribution id to invalidate after syncing

The following is a sample S3 configuration in your .drone.yml file:

```yaml
pipeline:
  s3_sync:
    region: "us-east-1"
    acl: public-read
    bucket: "my-bucket.s3-website-us-east-1.amazonaws.com"
    aws_access_key_id: "970d28f4dd477bc184fbd10b376de753"
    aws_secret_access_key: "9c5785d3ece6a9cdefa42eb99b58986f9095ff1c"
    source: folder/to/archive
    target: /target/location
    exclude: "*.map"
    include: "*.log"
    delete: true
    cloudfront_distribution_id: "9c5785d3ece6a9cdefa4"
```
