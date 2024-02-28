variable "location" {
  description = "The location of the deployed resources"
  type        = string
  default     = "Sweden Central"
}

variable "container_app_env_name" {
  description = "The name of the container app environment"
  type        = string
}

variable "container_app_job_name" {
  description = "The name of the Container App Job resource"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "log_workspace_name" {
  description = "The name of the log analytics workspace"
  type        = string
}

variable "docker_image" {
  description = "The path to the docker image hosted on docker hub"
  type        = string
}

