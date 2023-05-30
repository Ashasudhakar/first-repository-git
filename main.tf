data "aws_vpc" "selected" {
  tags = {
    Name ="testing-vpc"
  }
}

data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name = "tag:Name"
    values = ["*-private-*"]
  }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.example.ids)
  id       = each.value
}

locals {
    dev = [ for s in data.aws_subnet.example : s ]
}

locals {
    dev2 = flatten([
        for k, v in local.dev : v.id
            if !can(v.tags.automation)
    ])
}

output "test" {
  value = local.dev2
}