# https://docs.gitlab.com/charts/development/minikube/#starting--stopping-minikube
cluster-up:
	minikube start -p atlaminitlab --cpus=4 --memory=6144
	minikube addons enable metrics-server

delete-context:
	kubectx -d atlaminitlab

stop-cluster:
	minikube stop -p atlaminitlab

delete-cluster: stop-cluster
	minikube delete -p atlaminitlab

use-context:
	kubectx atlaminitlab

teardown: destroy delete-cluster delete-context

oneshot-run: provision plan apply

provision: cluster-up use-context

plan: use-context
	cd terraform && make plan

apply: use-context
	cd terraform && make apply

destroy:
	cd terraform && make destroy
