resource "aws_lb_target_group" "tg-example" {
  name     = "tg-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.autoscalling.id
  lb_target_group_arn    = aws_lb_target_group.tg-example.arn
}