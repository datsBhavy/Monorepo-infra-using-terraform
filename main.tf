module "staging" {
  source         = "./dev-environment"
  instance_count = 3
  instance_type  = "t3.micro"
  environment    = "staging"
  min_instance   = 1
  max_instance   = 3
  subdomain_name = "stage"
  domain_name    = "bhavy.abhishekkothari.in"
}

module "production" {
  source         = "./dev-environment"
  instance_count = 5
  instance_type  = "c6i.large"
  environment    = "production"
  min_instance   = 2
  max_instance   = 4
  subdomain_name = "production"
  domain_name    = "bhavy.abhishekkothari.in"
}