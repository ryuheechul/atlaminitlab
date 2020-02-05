data "helm_repository" "gitlab" {
  name = "gitlab"
  url  = "https://charts.gitlab.io"
}

resource "helm_release" "gitlab" {
  name       = "gitlab"
  repository = data.helm_repository.gitlab.metadata[0].name
  chart      = "gitlab"
  version    = "3.0.3"

  values = [
    "${file("../helm/gitlab-values.yaml")}"
  ]
}

