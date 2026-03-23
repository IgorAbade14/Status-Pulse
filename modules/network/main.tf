# ======================================================
# NETWORK MODULE: THE FOUNDATION (VPC & CONNECTIVITY)
# ======================================================

# 1. VPC: Your isolated data center in the AWS Cloud
resource "aws_vpc" "status_pulse_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  
  tags = { 
    Name    = "vpc-status-pulse-${var.environment}"
    Project = "Status-Pulse"
  }
}

# 2. Subnet: A specific segment within an Availability Zone
resource "aws_subnet" "status_pulse_subnet" {
  vpc_id            = aws_vpc.status_pulse_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # North Virginia

  map_public_ip_on_launch = true # Critical for our Dashboard access
  
  tags = { 
    Name        = "subnet-status-pulse-${var.environment}"
    Environment = var.environment
  }
}

# 3. Internet Gateway: The "Door" to the World Wide Web
resource "aws_internet_gateway" "status_pulse_igw" {
  vpc_id = aws_vpc.status_pulse_vpc.id
  
  tags = { Name = "igw-status-pulse-${var.environment}" }
}

# 4. Route Table: The "GPS" for network traffic
resource "aws_route_table" "status_pulse_public_rt" {
  vpc_id = aws_vpc.status_pulse_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # "All external destinations..."
    gateway_id = aws_internet_gateway.status_pulse_igw.id # "...go through the Gateway"
  }
}

# 5. Association: Makes the subnet PUBLIC by linking it to the Route Table
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.status_pulse_subnet.id
  route_table_id = aws_route_table.status_pulse_public_rt.id
}