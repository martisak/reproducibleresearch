
docker:
	docker build -t martisak/reproducibleresearch .

submods:
	git submodule update --recursive --remote

.PHONY: clean

push:
	docker push martisak/reproducibleresearch:latest
## Build docker
