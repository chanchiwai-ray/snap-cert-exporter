PROJECTPATH=$(dir $(realpath ${MAKEFILE_LIST}))
SNAP_NAME=$(shell cat ${PROJECTPATH}/snap/snapcraft.yaml | grep -E '^name:' | awk '{print $$2}')
SNAP_FILE=$(shell find -name ${SNAP_NAME}*.snap)

help:
	@echo "This project supports the following targets"
	@echo ""
	@echo " make help	-	show this text"
	@echo " make build	-	build the snap"
	@echo " make install	-	install the snap"
	@echo " make uninstall	-	uninstall the snap if it's installed"
	@echo " make clean -	remove unneeded files"
	@echo ""

build:
	@echo "Building the snap"
	@snapcraft --use-lxd

clean:
	@echo "Cleaning the existing snap"
	@snapcraft clean --use-lxd
	@rm -rf ${SNAP_FILE}

install:
ifndef SNAP_FILE
	$(error "You need to build the snap by running `make build` first")
endif
	@echo "Installing the snap"
	@snap install --devmode ${SNAP_FILE}

uninstall:
	@echo "Uninstalling the snap"
	@snap remove ${SNAP_NAME}

.PHONY: help build clean install uninstall
