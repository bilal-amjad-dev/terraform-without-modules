/*
# Define the required AWS provider and its version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0" # Lock to a specific version for consistency
    }
  }
}

# Configure the AWS provider with the desired region
provider "aws" {
  region = "ap-south-1"
}

# Create the Virtual Private Cloud (VPC)
# This resource defines the main network container for your AWS resources.
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16" # The IP address range for the VPC
  enable_dns_support   = true          # Enables DNS resolution within the VPC
  enable_dns_hostnames = true          # Enables DNS hostnames for instances in the VPC

  tags = {
    Name = "my-vpc"
  }
}

# Create a Public Subnet
# This subnet will be accessible from the internet.
resource "aws_subnet" "my_public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"       # IP address range for the public subnet
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true                # Automatically assigns public IP addresses to instances launched in this subnet

  tags = {
    Name = "my-public-subnet"
  }
}

# Create an Internet Gateway (IGW)
# The IGW allows communication between your VPC and the internet.
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

# Create a Route Table for the Public Subnet
# This route table defines rules for routing network traffic.
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  # Define a route to the internet (0.0.0.0/0) via the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

# Associate the Public Subnet with the Public Route Table
# This links the subnet to the routing rules defined in the route table.
resource "aws_route_table_association" "my_public_subnet_association" {
  subnet_id      = aws_subnet.my_public_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# Create a Security Group for the EC2 instance
# This security group will allow SSH (port 22) and HTTP (port 80) access from anywhere.
resource "aws_security_group" "my_ec2_sg" {
  name        = "my-ec2-security-group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id # Associate with the created VPC

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-ec2-sg"
  }
}

# EC2 Instance
# This resource defines an EC2 instance that will be launched in the public subnet
# and associated with the newly created security group.
resource "aws_instance" "my_ec2" {
  ami           = "ami-0dee22c13ea7a9a67" # Replace with an AMI ID valid for ap-south-1 (e.g., Amazon Linux 2 AMI)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_public_subnet.id # Place the EC2 instance in the public subnet
  vpc_security_group_ids = [aws_security_group.my_ec2_sg.id] # Attach the security group

  # Optional: Add a key pair if you want to SSH into the instance
  # key_name = "your-key-pair-name"

  tags = {
    Name = "my-ec2"
  }
}

*/

# S3 Bucket
# This resource creates a simple S3 bucket.
# Bucket names must be globally unique.
resource "aws_s3_bucket" "my_simple_bucket" {
  bucket = "my-unique-simple-bucket-12345-02-july-2025" # IMPORTANT: This name MUST be globally unique. Choose a different name!

  tags = {
    Name = "my-simple-bucket"
  }
}
