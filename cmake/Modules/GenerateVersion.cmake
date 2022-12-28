# Always run during 'make'

if(DEVELOPMENT_BUILD)
	execute_process(COMMAND git rev-parse --short HEAD
		WORKING_DIRECTORY "${GENERATE_VERSION_SOURCE_DIR}"
		OUTPUT_VARIABLE VERSION_GITHASH OUTPUT_STRIP_TRAILING_WHITESPACE
		ERROR_QUIET)
	if(VERSION_GITHASH)
		set(VERSION_FINAL "")
		execute_process(COMMAND git diff-index --quiet HEAD
			WORKING_DIRECTORY "${GENERATE_VERSION_SOURCE_DIR}"
			RESULT_VARIABLE IS_DIRTY)
		if(IS_DIRTY)
			set(VERSION_FINAL "(git-${VERSION_GITHASH}-dirty)")
		else()
			set(VERSION_FINAL "${VERSION_STRING} (git-${VERSION_GITHASH})")
		endif()
		message(STATUS "*** Detected Git version ${VERSION_FINAL} ***")
	endif()
endif()
if(NOT VERSION_GITHASH)
	set(VERSION_GITHASH "${VERSION_STRING}")
endif()

configure_file(
	${GENERATE_VERSION_SOURCE_DIR}/cmake_config_githash.h.in
	${GENERATE_VERSION_BINARY_DIR}/cmake_config_githash.h)

