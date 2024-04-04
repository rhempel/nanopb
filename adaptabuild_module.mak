# ----------------------------------------------------------------------------
# nanopb makefile
#
# This is designed to be included as part of a make system designed
# to be expandable and maintainable using techniques found in:
#
# Managing Projects with GNU Make - Robert Mecklenburg - ISBN 0-596-00610-1
# ----------------------------------------------------------------------------

MODULE := nanopb

MODULE_PATH := $(call make_current_module_path)
$(call log_debug,MODULE_PATH is $(MODULE_PATH))

$(MODULE)_PATH := $(MODULE_PATH)
$(call log_debug,$(MODULE)_PATH is $($(MODULE)_PATH))

# ----------------------------------------------------------------------------
# Source file lists go here, C dependencies are automatically generated
# by the compiler using the -m option
#
# You can set up a common source path late in the file
#
# Note that each module gets its own, privately scoped variable for building
# ----------------------------------------------------------------------------

# We need both else a previous definition is used :-) Can we make this an include?

SRC_C :=  
SRC_ASM :=  
SRC_TEST :=

# Here is where we begin to add files to list of sources

SRC_C += pb_common.c
SRC_C += pb_decode.c
SRC_C += pb_encode.c

# We also have to add the simple example source here for the POC - in a real
# project the .proto files would autogenerate .pb.c and .pb.h files in a
# separate location.

SRC_C += examples/simple/simple.pb.c

# We will deal with building and running the test suite separately, or
# just assume it works simce it's coming from an open source site
# that runs the tests.

# ----------------------------------------------------------------------------
# Set up the module level specifics for the source, include, and object paths

$(MODULE)_SRCPATH :=
$(MODULE)_SRCPATH += $(MODULE_PATH)
$(MODULE)_SRCPATH += $(MODULE_PATH)/examples/simple

$(MODULE)_INCPATH := $(MODULE_PATH)

ifeq (unittest,$(MAKECMDGOALS))
#  $(MODULE)_SRCPATH += $(MODULE_PATH)/unittest

#  $(MODULE)_INCPATH += $(MODULE_PATH)/src
#  $(MODULE)_INCPATH += $(MODULE_PATH)/unittest
endif

# ----------------------------------------------------------------------------
# NOTE: The default config file must be created somehow - it is normally
#       up to the developer to specify which defines are needed and how they
#       are to be configured.
#
# By convention we place config files in $(PRODUCT)/config/$(MCU) because
# that's an easy pace to leave things like HAL config, linker scripts etc

$(MODULE)_INCPATH += $(PRODUCT)/config/$(MCU)

# ----------------------------------------------------------------------------
# Set any module level compile time defaults here

$(MODULE)_CDEFS :=
$(MODULE)_CDEFS +=

$(MODULE)_CFLAGS :=
$(MODULE)_CFLAGS +=

ifeq (unittest,$(MAKECMDGOALS))
  $(MODULE)_CDEFS +=
endif

# ----------------------------------------------------------------------------
# Include the adaptabuild library makefile - must be done for each module!

include $(ADAPTABUILD_PATH)/make/library.mak

# ----------------------------------------------------------------------------
# Include the unit test framework makefile that works for this module
# if the target is unittest

ifeq (unittest,$(MAKECMDGOALS))
# TESTABLE_MODULES += $(MODULE)_UNITTEST
#  $(MODULE)_test_main := unittest/main.o
#  include $(ADAPTABUILD_PATH)/make/test/cpputest.mak
endif

# ----------------------------------------------------------------------------
