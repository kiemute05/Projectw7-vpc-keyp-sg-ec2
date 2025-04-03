resource "aws_security_group" "terraformsg-docker" {
  name        = "terraformsg-docker"
  description = "Security group for terraform docker project"
  vpc_id      = aws_vpc.terraform-vpc-docker.id # Replace with your VPC ID

  # Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["107.136.167.181/32"]  # Allow SSH from anywhere (modify for security)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic from anywhere
  }

  ingress {
    from_port   = 8000
    to_port     = 8100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS traffic from anywhere
  }

  # Outbound Rules (Allow all traffic out)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraformsg-docker"
  }
  depends_on = [aws_vpc.terraform-vpc-docker]
}
