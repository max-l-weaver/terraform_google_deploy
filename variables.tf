variable "region" {
	default = "europe-west1"
}

variable "zone" {
	default = "europe-west1-c"
}

variable "project_name" {
	default = "infect-testing"
}

variable "credentials_file_path" {
	default = "~/.gcloud/infect-testing-0ab84e4dfaab.json"
}

variable "public_key_path" {
	default = "~/.ssh/gcloud_id.pub"
}

variable "private_key_path" {
	default = "~/.ssh/gcloud_id"
}

variable "main_image" {
	default = "ubuntu-os-cloud/ubuntu-1604-xenial-v20161011"
}

