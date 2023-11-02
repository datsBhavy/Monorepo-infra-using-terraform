resource "aws_lb" "lb" {
  name                       = "lb-${var.environment}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-sg.id]
  subnets                    = toset(data.aws_subnets.mysubnets.ids)
  enable_deletion_protection = false

  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_lb_listener" "web-lb" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-example.arn
  }
}

resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:643965772771:certificate/3d5f2d56-9557-4c33-b470-9e6d4a28253c"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-example.arn
  }
}