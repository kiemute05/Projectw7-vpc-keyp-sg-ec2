terraform {
  backend "s3" {
    bucket = "kpo-w7proj-terraformbucket"
    key    = "docker/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}