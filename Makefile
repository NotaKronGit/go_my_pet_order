SHELL:=/bin/bash
KIND:=kindest/node:v1.29.1
KIND_CLUSTER:=shop-cluster
BASE_IMAGE_NAME:=shop
SERVICE_NAME:=order
VERSION:=0.0.1
SERVICE_IMAGE:=$(BASE_IMAGE_NAME)/$(SERVICE_NAME):$(VERSION)
NAMESPACE:=shop-system
APP:=order

dev-up:
	kind create cluster \
		--image $(KIND) \
		--name $(KIND_CLUSTER) \
		--config ci/k8s/dev/kind-config.yaml

dev-down:
	kind delete cluster --name $(KIND_CLUSTER)

dev-load:
	kind load docker-image $(SERVICE_IMAGE) --name $(KIND_CLUSTER)

dev-log:
	kubectl logs --namespace=$(NAMESPACE) -l app=$(APP) --all-containers=true -f --tail=10

dev-apply:
	kustomize build ci/k8s/dev/order | kubectl apply -f -

img:
	docker build -f ci/Docker/order.dockerfile -t $(SERVICE_IMAGE) .
