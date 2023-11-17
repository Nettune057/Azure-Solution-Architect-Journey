locals {
    prefix_name = "${var.setup_name}-${var.env}"
    tags = {
        Environment = var.env
        Creator     = var.creator
        Project     = var.setup_name
    }

    rg_name         = "${local.prefix_name}-${var.rg_name}"
    rg_location     = var.rg_location
}

locals {}