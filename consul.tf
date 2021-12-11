# Configure the Consul provider
provider "consul" {
  address    = "demo.consul.io:80"
  datacenter = "nyc1"
}

# Access a key in Consul
data "consul_keys" "app" {
  key {
    name    = "ami"
    path    = "service/app/launch_ami"
    default = "ami-0ed9277fb7eb570c9 "
  }
}

# Use our variable from Consul
resource "aws_instance" "app" {
  ami = data.consul_keys.app.var.ami
}
