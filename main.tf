# Manage GCP Project with TF
# Note that we use a hack: gcloud is called at the command line to enable two specific services which make enabling other services possible.
# https://medium.com/rockedscience/how-to-fully-automate-the-deployment-of-google-cloud-platform-projects-with-terraform-16c33f1fb31f

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_project" "project-definition" {
  name            = var.project_id
  project_id      = var.project_id
  billing_account = var.billing_account
  folder_id       = var.folder_id
  labels          = var.labels
}

# Use `gcloud` to enable:
# - serviceusage.googleapis.com
# - cloudresourcemanager.googleapis.com
resource "null_resource" "enable_service_usage_api" {
  provisioner "local-exec" {
    command = "gcloud services enable serviceusage.googleapis.com cloudresourcemanager.googleapis.com --project ${var.project_id}"
  }

  depends_on = [google_project.project-definition]
}

resource "google_project_service" "services" {
  for_each = toset(var.services)

  project                    = var.project_id
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false

  depends_on = [null_resource.enable_service_usage_api]
}
