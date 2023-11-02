resource "aws_autoscaling_group" "autoscalling" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = var.min_instance
  max_size           = var.max_instance
  min_size           = var.min_instance

  launch_template {
    id      = aws_launch_template.sample1.id
    version = "$Latest"
  }
}
