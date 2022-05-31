variable "project" {
  type = string
  default = "active-defender-350709"
}

variable "gcp_creds" {
  type        = string
  sensitive   = true
  description = "Google Cloud service account credentials"
}

variable "ssh_user" {
  type      = string
  sensitive = true
}

variable "ssh_key" {
  type      = string
  sensitive = true
}
