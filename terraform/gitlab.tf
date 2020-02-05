data "helm_repository" "gitlab" {
  name = "gitlab"
  url  = "https://charts.gitlab.io"
}

data "external" "minikube_ip" {
  program = [
    "sh", "-c", "minikube -p atlaminitlab ip | jq -R {\"ip\":.}"
  ]
}

resource "helm_release" "gitlab" {
  name       = "gitlab"
  repository = data.helm_repository.gitlab.metadata[0].name
  chart      = "gitlab"
  version    = "3.0.3"

  values = [
    "${file("../helm/gitlab-values.yaml")}"
  ]

  set {
    name = "global.hosts.domain"
    value = join(
      "",
      [lookup(data.external.minikube_ip.result, "ip"), ".nip.io"]
    )
  }

  set {
    name  = "global.hosts.externalIP"
    value = lookup(data.external.minikube_ip.result, "ip")
  }
}

