#clean will remove running containers and server config
#sterile will clean, then remove ALL volumes and ALL images- even unrelated ones

TARGET ?= .
NAME ?= instance1
KEY ?= java8

ROOT = ${abspath .}
RUNTIME = ${ROOT}/runtime
IMAGES = ${ROOT}/config/images
COMPOSITIONS = ${ROOT}/config/compositions

VOLUMES = ${abspath ${RUNTIME}/volumes}
SOURCE = ${abspath ${ROOT}/source}

INSTANCE = ${abspath ${RUNTIME}/${NAME}/${TARGET}}
INSTANCE_VOLUME = ${abspath ${VOLUMES}/${NAME}/${TARGET}}
INSTANCE_SOURCE = ${abspath ${SOURCE}/${TARGET}}

CPLEX_IMAGE_DIR = ${IMAGES}/cplex_python3
GUROBI_IMAGE_DIR = ${IMAGES}/gurobi_python3
JAVA8_IMAGE_DIR = ${IMAGES}/java8
VAPORY_IMAGE_DIR = ${IMAGES}/vapory

export PATH := ${abspath ${ROOT}/runtime/bin/}:${PATH}

default: images instance

images: cplex_image gurobi_image java8_image vapory_image

cplex_image: ${CPLEX_IMAGE_DIR}/Dockerfile 
	docker build --tag gp/cplex ${CPLEX_IMAGE_DIR}

gurobi_image: ${GUROBI_IMAGE_DIR}/Dockerfile 
	docker build --tag gp/gurobi ${GUROBI_IMAGE_DIR}

java8_image: ${JAVA8_IMAGE_DIR}/Dockerfile 
	docker build --tag gp/java8 ${JAVA8_IMAGE_DIR}

vapory_image: ${VAPORY_IMAGE_DIR}/Dockerfile 
	docker build --tag gp/vapory ${VAPORY_IMAGE_DIR}

instance: volume_link compositions deploy #package

volume_link: ${INSTANCE}/workspace_volume  

${INSTANCE}/workspace_volume: ${INSTANCE_VOLUME} ${INSTANCE}  
	ln -sf ${INSTANCE_VOLUME} ${INSTANCE}/workspace_volume 

${INSTANCE_VOLUME}:
	mkdir -p ${INSTANCE_VOLUME}
	mkdir -p ${INSTANCE_VOLUME}/lib

${INSTANCE}:
	mkdir -p ${INSTANCE}

package: deploy
	cd ${INSTANCE}/workspace_volume/solver && mvn package

compositions:
	cp -rf ${COMPOSITIONS}/* ${INSTANCE}

deploy:
	cp -rf ${INSTANCE_SOURCE}/* ${INSTANCE_VOLUME}
	cp -rf ${SOURCE}/lib ${INSTANCE_VOLUME}

clean:
	rm -rf ${INSTANCE}
	exec docker-clean

cleaner: clean
	rm -rf ${VOLUMES}/*

sterile: cleaner
	exec docker-rmi

