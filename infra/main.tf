terraform {
  // aws 라이브러리 불러옴
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# AWS 설정 시작
provider "aws" {
  region = var.region // 테라폼은 기본적으로 같은 폴더에 있는 파일이 import돼서 var로 쓸 수 있음
}
# AWS 설정 끝

# VPC 설정 시작
resource "aws_vpc" "vpc_1" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}-vpc-1"
  }

  
}

resource "aws_vpc" "vpc_2" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}-vpc-2"
  }

  
}