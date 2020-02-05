cluster-up:
	minikube start -p atlaminitlab

provision: cluster-up use-context

use-context:
	kubectx atlaminitlab

delete-context:
	kubectx -d atlaminitlab

stop-cluster:
	minikube stop -p atlaminitlab

delete-cluster: stop-cluster
	minikube delete -p atlaminitlab

teardown: delete-cluster delete-context
