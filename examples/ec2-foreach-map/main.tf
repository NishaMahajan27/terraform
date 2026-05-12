resource "aws_instance" "vm2" {
  for_each      = var.instances
  ami           = "ami-0a59248a6294cece2"
  instance_type = each.value
  key_name      = "aws-key"

  user_data = <<-EOF
    #!/bin/bash
    sudo -i
    yum install httpd -y
    systemctl start httpd
    echo "Infra As a Code" > /var/www/html/index.html
  EOF

  tags = {
    Name = "vm-${each.key}"
  }
}
