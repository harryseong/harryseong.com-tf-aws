# harryseong.com-tf

## Manual Steps:
1. Setup a registered public domain in AWS management console.
2. Set CloudFront's Route53 record module's "create" attribute to "false" for first "terraform apply".

3. Run "terraform apply".

4. NAT instance (EC2 spot instance) source/destinaton check must be manually disabled (due to current Terraform limitations with spot instances).
5. CodeStarConnection authentication to GitHub must be completed manually via AWS management console.
    - AWS management console: AWS Developer Tools > Settings > Connections
6. Set CloudFront's Route53 record module's "create" attribute to "true" for second "terraform apply".

7. Run "terraform apply".
