CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)
MAKEFILE_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
WKFLAGS = --log-level info --dpi 150 --disable-smart-shrinking
WKMARGINS = --margin-bottom 1mm --margin-top 1mm --margin-left 1mm --margin-right 1mm


.PHONY: all
all: clean configure pdf


.PHONY: clean
clean:
	rm -rf $(MAKEFILE_DIR)/build/*

.PHONY: pdf
pdf: html pdf-wk-with-flags pdf-wk-no-flags pdf-pandoc
