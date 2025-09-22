cmake_minimum_required(VERSION 3.27)

# include(CMAKE_TOOLCHAIN_FILE="${CMAKE_CURRENT_SOURCE_DIR}/toolchains/${TOOLCHAIN}.cmake")

# 1 for 64 bits build, 0 for 32 bits build
set(GGPO_64BIT 0)

# Choose the build generator from:
# Borland Makefiles
# MSYS Makefiles
# MinGW Makefiles
# NMake Makefiles
# NMake Makefiles JOM
# Unix Makefiles
# Watcom WMake
#
# Ninja
# Ninja Multi-Config
#
# Visual Studio 14 2015
# Visual Studio 15 2017
# Visual Studio 16 2019
# Visual Studio 17 2022
# Type in the command like: cmake -G "<generator>"
# As the default one cannot be changed from inside CMake files

if(NOT CMAKE_GENERATOR)
	message("Defaulting to Ninja single-configuration generator!")
	set(CMAKE_GENERATOR "Ninja")
endif()

message("Generating the ${CMAKE_GENERATOR} build files!")

# Choose the operating system between Windows, Linux or Darwin (the last one for Mac OS)
# TO DO: Set other parameters and files to successfully build Linux files
set(CMAKE_SYSTEM_NAME Windows)

if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
	message("Configuring files for Windows!")
	set(WIN32 True)
	set(PROJECT_BINARY_DIR "build")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
	message("Configuring files for Linux!")
	set(UNIX True)
	set(PROJECT_BINARY_DIR "build")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
	message("Configuring files for Mac OS")
	set(UNIX True)
	set(PROJECT_BINARY_DIR "build")
else()
	message("No Operating System was set. Defaulting to Windows!")
	set(WIN32 True)
endif()

# Choose the compilers for C and C++.
set(CMAKE_C_COMPILER gcc) # gcc, clang or cl
set(CMAKE_CXX_COMPILER g++) # g++, clang++ or cl
message("Using ${CMAKE_C_COMPILER} as a C compiler!")
message("Using ${CMAKE_CXX_COMPILER} as a C++ compiler!")

if(NOT CMAKE_C_COMPILER OR NOT CMAKE_CXX_COMPILER)
	message("One or both compilers were not set. Defaulting to GCC and G++!")
	set(CMAKE_C_COMPILER clang)
	set(CMAKE_CXX_COMPILER clang++)
endif()

# Set the standards for C and C++
# The options for C are: 11 and 17
# The options for C++ are: 14, 17 and 20
set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message("Standards: C${CMAKE_C_STANDARD} and C++${CMAKE_CXX_STANDARD}")

# All the possible build configuration types for multi-configurations files like VS and Ninja
# set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo" CACHE STRING "" FORCE)
# message("\nCMAKE_CONFIGURATION_TYPES are ${CMAKE_CONFIGURATION_TYPES}\n")

# Configuration type for single-configuration files like Makefiles. Debub, Release and RelWithDebInfo can be used
if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "" FORCE)
endif()

include(src/cmake/properties.cmake)
include(src/cmake/helper_methods.cmake)

# TO DO: SDK Versioning.
project(GGPO VERSION 1.0.0)

##################################################################################################################

# include(src/cmake/properties.cmake)
# include(src/cmake/helper_methods.cmake)

if(WIN32)
	## Prevent the CMake trying to install GGPO in Program Files on Windows
	if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
		set (CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/installed/${CMAKE_BUILD_TYPE}" CACHE PATH "Default install path" FORCE)
		message("Preventing CMake from installing GGPO in Program Files! The files will be put in ${CMAKE_BINARY_DIR}/installed/${CMAKE_BUILD_TYPE}\n")
	endif()
endif()

# What do we want to build?
option(GGPO_BUILD_SDK "Enable the build of the GGPO SDK" ON)
option(GGPO_BUILD_VECTORWAR "Enable the build of the Vector War example app" OFF)
option(BUILD_SHARED_LIBS "Enable the build of shared libraries (.dll/.so) instead of static ones (.lib/.a)" ON)

if(GGPO_BUILD_SDK)
	add_subdirectory(src)
endif()

if(GGPO_BUILD_VECTORWAR)
	# Vector War is Windows only.
	if(WIN32)
		add_subdirectory(src/apps/vectorwar)
	else()
		message(WARNING "The Vector War app only supports Windows, skipping...")
	endif()
endif()
