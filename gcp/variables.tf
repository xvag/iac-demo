variable "gcp_project" {
  type      = string
  sensitive = true
  description = "Google Cloud project ID"
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

variable "c-region" {
  type = string
}

variable "c-zone" {
  type = string
}

variable "c-subnet" {
  type = string
}

variable "c-machine" {
  type = string
}

variable "c-image" {
  type = string
}

variable "c-size" {
  type = string
}

variable "w-region" {
  type = string
}

variable "w-zone" {
  type = string
}

variable "w-subnet" {
  type = string
}

variable "w-machine" {
  type = string
}

variable "w-image" {
  type = string
}

variable "w-size" {
  type = string
}

variable "controller-no" {
  type = number
}

variable "controller-name" {
  type = list(string)
}

variable "controller-ip" {
  type = list(string)
}

variable "worker-no" {
  type = number
}

variable "worker-name" {
  type = list(string)
}

variable "worker-ip" {
  type = list(string)
}

variable "pod-cidr" {
  type = list(string)
}

variable "pod-cidr-range" {
  type = string
}
