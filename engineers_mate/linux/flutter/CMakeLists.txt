# This file controls Flutter-level build steps. It should not be edited.
cmake_minimum_required(VERSION 3.10)

set(EPHEMERAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ephemeral")

# Configuration provided via flutter tool.
include(${EPHEMERAL_DIR}/generated_config.cmake)

# The rest of the configuration is now moved into ephemeral files.
# See https://github.com/flutter/flutter/issues/57146.
include(${EPHEMERAL_DIR}/generated_flutter_library.cmake)
