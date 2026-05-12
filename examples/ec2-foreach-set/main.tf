resource "aws_instance" "vm2" {
  for_each      = toset(["BACKEND", "FRONTEND", "DATABASES"])
  ami           = "ami-0a59248a6294cece2"
  instance_type = "t3.micro"
  key_name      = "aws-key"

  user_data = <<-EOF
    #!/bin/bash
    sudo -i
    yum install httpd -y
    systemctl start httpd
    echo "Infra As a Code" > /var/www/html/index.html
  EOF

  tags = {
    Name = "env-${each.key}"
  }
}
