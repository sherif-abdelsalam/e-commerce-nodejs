output "alb_dns" {
  value = aws_lb.this.dns_name
}

output "ecr_url" {
  value = aws_ecr_repository.app.repository_url
}

output "asg_name" {
  value = aws_autoscaling_group.this.name
}