locals {
  common_tags = {
    Name        = var.app_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  name_prefix = "${var.app_name}-${var.environment}"
}