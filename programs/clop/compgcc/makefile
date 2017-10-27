include ../../_general/compgcc/options.mk
include ../../plot/compgcc/plot.mk
include ../../rclib/compgcc/rclib.mk
include ../../clop/compgcc/clop.mk

.PHONY: all clean clean-swig

all: bin/clop swig

ALLOBJECTS:=$(OBJECTS)

CLOPOBJECT:=../../clop/compgcc/bin/clop.o

CLOPOBJECTS:=$(OBJECTS) $(CLOPOBJECT)

ALLOBJECTS:=$(ALLOBJECTS) $(CLOPOBJECT)

bin/clop: $(CLOPOBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS)

#############################################################################
# SWIG
#############################################################################
include ../../_general/swig/swig.mk

#############################################################################
# clean
#############################################################################
clean: clean-swig
	rm  -f ../swig/_clop_swig.so \
        ../swig/clop_swig.py \
        ../swig/clop_swig_wrap.cxx \
        ../swig/clop_swig_wrap.d \
        ../swig/clop_swig_wrap.o \
        ../swig/i.tmp \
        ../swig/py.tmp \
        ../../plot/compgcc/bin/CContour.o \
        ../../plot/compgcc/bin/CDiscretizedLine.o \
        ../../plot/compgcc/bin/CPGF.o \
        ../../plot/compgcc/bin/CPlot.o \
        ../../plot/compgcc/bin/CSplineFit.o \
        ../../rclib/compgcc/bin/CTimeIO.o \
        ../../rclib/compgcc/bin/ReadLineToString.o \
        ../../rclib/compgcc/bin/chtime.o \
        ../../rclib/compgcc/bin/clktimer.o \
        ../../rclib/compgcc/bin/consolui.o \
        ../../rclib/compgcc/bin/justtext.o \
        ../../rclib/compgcc/bin/mybeep.o \
        ../../rclib/compgcc/bin/mykbhit.o \
        ../../rclib/compgcc/bin/readstr.o \
        ../../rclib/compgcc/bin/userflag.o \
        ../../rclib/compgcc/bin/version.o \
	rm -rvf `cat .gitignore`
	cd bin; rm -vf `cat .gitignore`

#############################################################################
# cppcheck
#############################################################################
cppcheck:
	cppcheck -D --enable=all -v $(INCLUDES) ../src

#############################################################################
# Automatic dependencies
#############################################################################
-include $(ALLOBJECTS:.o=.d)
