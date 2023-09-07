#pragma once

#if defined USE_CMAKE_CONFIG_H
	#include "cmake_config.h"
#else
	#if defined (__ANDROID__)
		#define PROJECT_NAME "freecraft"
		#define PROJECT_NAME_C "FreeCraft"
		#define STATIC_SHAREDIR ""
		#define ENABLE_UPDATE_CHECKER 0
		#define VERSION_STRING STR(VERSION_MAJOR) "." STR(VERSION_MINOR) "." STR(VERSION_PATCH) STR(VERSION_EXTRA)
	#endif
	#ifdef NDEBUG
		#define BUILD_TYPE "Release"
	#else
		#define BUILD_TYPE "Debug"
	#endif
#endif
