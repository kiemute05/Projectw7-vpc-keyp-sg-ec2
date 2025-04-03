# Generate a new RSA key pair locally
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#public key in aws
resource "aws_key_pair" "my_key" {
  key_name   = "terraformdockerkey" # Name of the key pair
  public_key = tls_private_key.ssh_key.public_key_openssh # Path to your public key file
}


# Download key
resource "local_file" "localf1" {
    filename = "terraformdockerkey.pem"
    content = tls_private_key.ssh_key.private_key_openssh
  file_permission = 0400
  
}