# ---- EC2 instance ----
resource "aws_instance" "web" {
  ami                         = "ami-053b0d53c279acc90" #this is the amazon linux ami id
  instance_type         = var.instance_type
  security_groups             = [aws_security_group.tf-sg.name]
  key_name                    = "terraform-kp"
  user_data_replace_on_change = true
  user_data                   = <<EOF
#!/bin/bash 
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs nginx -y
sudo npm i -g pm2   
pwd
cd /home/ubuntu
git clone https://github.com/datsBhavy/simple-web-app.git
cd simple-web-app
mv web.conf /etc/nginx/sites-enabled/xyz.conf
rm -rf /etc/nginx/sites-enabled/default
service nginx restart
npm i 
export HOME=/root
pm2 start --name backend node -- index.js
  EOF

  tags = {
    Name = "tf-instance-${var.i}-${var.environment}"
  }
}
# -----------------------------------------------------------------------------------------------------------------
# ----security group---- 
data "aws_vpc" "selected" {
  default = true
}


resource "aws_security_group" "tf-sg" {
  name        = "tf-sg-${var.i}-${var.environment}"
  description = "sg using tf"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tf-sg"
  }
}

# ----Configure EIP and attach to EC2----
# resource "aws_eip" "terraform-eip" {
#   instance = aws_instance.web.id
#   tags = {
#     Name = "Webip"
#   }
# }

resource "aws_lb_target_group_attachment" "lb" {
  target_group_arn = var.tg_arn
  target_id        = aws_instance.web.id
  port             = 80
}

# -----------------------------------------------------------------------------------------------------------------
  # ----keyPair----
  #   resource "aws_key_pair" "terraform-key" {
  #     key_name   = "terraform-key"
  #     public_key = tls_private_key.rsa.public_key_openssh
  #   }

  #   # RSA key of size 4096 bits
  #   resource "tls_private_key" "rsa" {
  #     algorithm = "RSA"
  #     rsa_bits  = 4096
  #   }

  #   resource "local_file" "terraform-key" {
  #     content  = tls_private_key.rsa.private_key_pem
  #     filename = "terraform-key"
  #   }

# -----------------------------------------------------------------------------------------------------------------
# # ---- make an exisiting instance ami ---- 
# resource "aws_ami_from_instance" "tf-image" {
#   name               = "tf-image"
#   source_instance_id = aws_instance.web.id
# }

# resource "aws_instance" "v1" {
#   ami             = aws_ami_from_instance.tf-image.id
#   instance_type   = "t3.micro"
#   security_groups = [aws_security_group.tf-sg.name]
#   key_name        = "terraform-kp"
#   tags = {
#     Name = "tf-v1"
#   }
# }