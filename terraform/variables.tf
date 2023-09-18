variable "do_token" {
  default = ""
}

variable "region" {
  default = "sgp1"
}

variable "k8s_clustername" {
  default = "satrio-work"
}

variable "k8s_version" {
  default = "1.27.4-do.0"
}

variable "k8s_poolname" {
  default = "worker-pool"
}

variable "k8s_min" {
  default = "1"
}

variable "k8s_max" {
  default = "3"
}
