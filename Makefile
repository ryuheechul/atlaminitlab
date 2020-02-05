cluster-up:
	minikube start -p atlaminitlab

delete-context:
	kubectx -d atlaminitlab

stop-cluster:
	minikube stop -p atlaminitlab

delete-cluster: stop-cluster
	minikube delete -p atlaminitlab

use-context:
	kubectx atlaminitlab

teardown: delete-cluster delete-context

provision: cluster-up use-context

plan: provision
	cd terraform && make plan
