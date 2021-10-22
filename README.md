# harryseong.com-tf

## Manual Steps:
1. [AWS Management Console: Route53] Setup a registered public domain.
2. [Terraform Code] Set all CloudFront Route53 record module "create" attribute to "false" for 1st run of "terraform apply".

3. Run "terraform apply".

4. [AWS Management Console: Route53] Update registered public domain with name servers of new Route53 public hosted domain.
5. [AWS Management Console: EC2] Disable NAT instance (EC2 spot instance) source/destinaton check (due to current Terraform limitations with spot instances).
    - Note: Private subnet's route table route to NAT instance will be created on second "terraform apply" after NAT instance status is "Running".
6. [AWS Management Console: Developer Tools] Complete CodeStarConnection authentication to GitHub.
    - (AWS Developer Tools > Settings > Connections)
7. [Terraform Code] Set all CloudFront Route53 record module "create" attribute to "true" for 2nd run of "terraform apply".

8. Run "terraform apply".
