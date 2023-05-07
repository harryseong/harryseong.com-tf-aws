# harryseong.com-tf-aws

## Manual Steps:
1. [AWS Management Console: Route53] Setup a registered public domain.
2. [Terraform Code] Set all CloudFront Route53 record module "create" attribute to "false" for 1st run of "terraform apply".

3. Run "terraform apply".

4. [AWS Management Console: Route53] Update registered public domain with name servers of new Route53 public hosted domain.
5. [AWS Management Console: EC2] Disable NAT instance (EC2 spot instance) source/destinaton check (due to current Terraform limitations with spot instances).
    - Note: Private subnet's route table route to NAT instance will be created on second "terraform apply" after NAT instance status is "Running".
6. [AWS Management Console: Developer Tools] Complete CodeStarConnection authentication to GitHub.
    - (AWS Developer Tools > Settings > Connections)
7. [AWS Management Console: Systems Manager] Update SSM Parameter Store SecureString parameter default values.
8. [Terraform Code] Set all CloudFront Route53 record module "create" attribute to "true" for 2nd run of "terraform apply".
9. [Google Cloud Platform Console] Add to authorized redirect URIs: "https://auth.harryseong.com/oauth2/idpresponse"
    - (APIs & Services > Credentials > OAuth 2.0 Client IDs > Authorized redirect URIs)

10. Run "terraform apply".


## Manual Steps - After NAT Spot Instance Replacement:
1. Run "terraform apply".

2. [AWS Management Console: EC2] Disable NAT instance (EC2 spot instance) source/destinaton check (due to current Terraform limitations with spot instances).
