terraform {
  backend "s3" {
    bucket = "github-actions-demo-12345678"
    key    = "github-actions-demo.tfstate"
    region = "us-east-1"
  }
}