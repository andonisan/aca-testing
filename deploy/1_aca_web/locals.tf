locals {
  project     = "andoni"
  prefix      = "e2etests"
  environment = var.environment
  rg_name     = "rg-${local.prefix}-${local.environment}"
  acr_name    = "${local.project}acr"
  aca_name    = "${local.prefix}${local.environment}"
  feature_name    = var.feature_name
  tags        = {
    "project"     = local.project
    "environment" = local.environment
  }
}