#!/bin/bash
skelmakefile(){
cat > Makefile << 'EOF'
#!/usr/bin/make -f
SHELL=/bin/bash
##
define README
# README
endef
export README
RUN := /bin/bash

all:
	@echo make readme
readme:
	-@echo "$$README"
version:
	$(RUN) \
	--version
EOF
}
