locals {
  project     = "andoni"
  prefix      = "e2etests"
  environment = var.environment
  rg_name     = "rg-${local.prefix}-${local.environment}"
  acr_name    = "${local.project}acr"
  sa_name    = "${local.project}sa"
  aca_name    = "${local.prefix}${local.environment}"
  law_name    = "${local.prefix}${local.environment}law"
  tags        = {
    "project"     = local.project
    "environment" = local.environment
  }
}