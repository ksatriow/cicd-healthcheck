provider "digitalocean"{
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name    = var.k8s_clustername
  region  = var.region
  version = var.k8s_version

  tags = ["k8s"]

  # This default node pool is mandatory
  node_pool {
    name       = var.k8s_poolname
    size       = "s-2vcpu-2gb" # minimum size, list available options with `doctl compute size list`
    auto_scale = true
    min_nodes  = var.k8s_min
    max_nodes  = var.k8s_max
    tags       = ["node-pool-tag"]
  }

}

output "cluster-id" {
  value = digitalocean_kubernetes_cluster.kubernetes_cluster.id
}