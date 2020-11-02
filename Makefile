LIBDIR := lib
IETFUSER=mcr+ietf@sandelman.ca
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b main https://github.com/martinthomson/i-d-template $(LIBDIR)
endif

submitit: draft-richardson-rats-usecases-08.xml
	curl -S -F "user=${IETFUSER}" -F "xml=@draft-richardson-rats-usecases-05.xml" https://datatracker.ietf.org/api/submit



