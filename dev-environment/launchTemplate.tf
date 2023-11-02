resource "aws_launch_template" "sample1" {
  image_id                             = "ami-053b0d53c279acc90"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t3.micro"
  key_name                             = "terraform-kp"
  user_data                            = "IyEvYmluL2Jhc2ggCiAgc3VkbyBhcHQtZ2V0IHVwZGF0ZQogIHN1ZG8gYXB0LWdldCBpbnN0YWxsIC15IGNhLWNlcnRpZmljYXRlcyBjdXJsIGdudXBnCiAgc3VkbyBta2RpciAtcCAvZXRjL2FwdC9rZXlyaW5ncwogIGN1cmwgLWZzU0wgaHR0cHM6Ly9kZWIubm9kZXNvdXJjZS5jb20vZ3Bna2V5L25vZGVzb3VyY2UtcmVwby5ncGcua2V5IHwgc3VkbyBncGcgLS1kZWFybW9yIC1vIC9ldGMvYXB0L2tleXJpbmdzL25vZGVzb3VyY2UuZ3BnCiAgTk9ERV9NQUpPUj0yMAogIGVjaG8gImRlYiBbc2lnbmVkLWJ5PS9ldGMvYXB0L2tleXJpbmdzL25vZGVzb3VyY2UuZ3BnXSBodHRwczovL2RlYi5ub2Rlc291cmNlLmNvbS9ub2RlXyROT0RFX01BSk9SLnggbm9kaXN0cm8gbWFpbiIgfCBzdWRvIHRlZSAvZXRjL2FwdC9zb3VyY2VzLmxpc3QuZC9ub2Rlc291cmNlLmxpc3QKICBzdWRvIGFwdC1nZXQgdXBkYXRlCiAgc3VkbyBhcHQtZ2V0IGluc3RhbGwgbm9kZWpzIG5naW54IC15CiAgc3VkbyBucG0gaSAtZyBwbTIgICAKICBwd2QKICBjZCAvaG9tZS91YnVudHUKICBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL2RhdHNCaGF2eS9zaW1wbGUtd2ViLWFwcC5naXQKICBjZCBzaW1wbGUtd2ViLWFwcAogIG12IHdlYi5jb25mIC9ldGMvbmdpbngvc2l0ZXMtZW5hYmxlZC94eXouY29uZgogIHJtIC1yZiAvZXRjL25naW54L3NpdGVzLWVuYWJsZWQvZGVmYXVsdAogIHNlcnZpY2UgbmdpbnggcmVzdGFydAogIG5wbSBpIAogIGV4cG9ydCBIT01FPS9yb290CiAgcG0yIHN0YXJ0IC0tbmFtZSBiYWNrZW5kIG5vZGUgLS0gaW5kZXguanM="
  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  tag_specifications {
    resource_type = "instance"
      tags = {
      Name = "sample1"
    }
  }
 
}