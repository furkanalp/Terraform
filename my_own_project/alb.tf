resource "aws_lb" "my_elb" {
  name               = "myelb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.loadbalancer_sg.id]
  subnets            = [for subnet in aws_subnet.private_subnets : subnet.id]
  enable_deletion_protection = false
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "my_listener_80" {
  load_balancer_arn = aws_lb.my_elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


resource "aws_lb_target_group" "my_tg_app1" {
  name     = "my-tg-app1"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.my_vpc.id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 6
    interval            = 30
    path                = "/app1/index.html"
    port                = "traffic-port"
    matcher             = "200-399"
  }
  protocol_version = "HTTP1"
}


resource "aws_lb_target_group_attachment" "attachment_app1" {
  target_group_arn = aws_lb_target_group.my_tg_app1.arn
  count = length(aws_instance.ec2_private_app1)
  target_id        = aws_instance.ec2_private_app1[count.index].id         # aws_instance.ec2_private_app1[count.index].id  # dosyada 52-59. satir arasi . Muhtemelen yanlis . [0] ve [1] olarak dene . eger olmazsa
  port             = 80                                   ### 3 tane target groups ve 3 tane attachment groups ve birbiryle instance.*.id seklinde bagla ! (setproduct bak!!)
}

resource "aws_lb_target_group" "my_tg_app2" {
  name     = "my-tg-app2"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.my_vpc.id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 6
    interval            = 30
    path                = "/app2/index.html"
    port                = "traffic-port"
    matcher             = "200-399"
  }
  protocol_version = "HTTP1"
}

resource "aws_lb_target_group_attachment" "attachment_app2" {
  target_group_arn = aws_lb_target_group.my_tg_app2.arn
  count = length(aws_instance.ec2_private_app2)
  target_id = aws_instance.ec2_private_app2[count.index].id   #aws_instance.ec2_private_app2[count.index].id  # dosyada 52-59. satir arasi . Muhtemelen yanlis . [0] ve [1] olarak dene . eger olmazsa
  port = 80                                    ### 3 tane target groups ve 3 tane attachment groups ve birbiryle instance.*.id seklinde bagla ! (setproduct bak!!)
}

resource "aws_lb_target_group" "my_tg_app3" {
  name     = "my-tg-app3"
  port     = 8080
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.my_vpc.id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 6
    interval            = 30
    path                = "/login"
    port                = "traffic-port"
    matcher             = "200-399"
  }
  protocol_version = "HTTP1"
}

resource "aws_lb_target_group_attachment" "attachment_app3" {
  target_group_arn = aws_lb_target_group.my_tg_app3.arn
  count = length(aws_instance.ec2_private_app3)
  target_id = aws_instance.ec2_private_app3[count.index].id  #aws_instance.ec2_private_app3[count.index].id  # dosyada 52-59. satir arasi . Muhtemelen yanlis . [0] ve [1] olarak dene . eger olmazsa
  port             = 8080                                 ### 3 tane target groups ve 3 tane attachment groups ve birbiryle instance.*.id seklinde bagla ! (setproduct bak!!)
}



resource "aws_lb_listener" "my_listener_443" {
  load_balancer_arn = aws_lb.my_elb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn    = data.aws_acm_certificate.acm-cert.arn
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed Static message - for Root Context"
      status_code  = "200"
    }
  }
}


resource "aws_lb_listener_rule" "rule_app1" {
  listener_arn = aws_lb_listener.my_listener_443.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_app1.arn
  }

  condition {
    path_pattern {
      values = ["/app1*"]
    }
  }
}

resource "aws_lb_listener_rule" "rule_app2" {
  listener_arn = aws_lb_listener.my_listener_443.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_app2.arn
  }

  condition {
    path_pattern {
      values = ["/app2*"]
    }
  }
}

resource "aws_lb_listener_rule" "rule_app3" {
  listener_arn = aws_lb_listener.my_listener_443.arn
  priority     = 3

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_app3.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}




### 3 tane target groups ve 3 tane attachment groups ve birbiryle instance.*.id seklinde bagla ! (setproduct bak!!)









