find_path(Hadrons_INCLUDE_DIR
  NAMES Hadrons/Global.hpp
)
find_library(Hadrons_LIBRARY
  NAMES Hadrons
)
find_program(Hadrons_CONFIG 
  NAMES hadrons-config
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Hadrons
  FOUND_VAR Hadrons_FOUND
  REQUIRED_VARS
    Hadrons_LIBRARY
    Hadrons_INCLUDE_DIR
    Hadrons_CONFIG
  VERSION_VAR Hadrons_VERSION
)

if(Hadrons_FOUND)
  set(Hadrons_LIBRARIES ${Hadrons_LIBRARY})
  set(Hadrons_INCLUDE_DIRS ${Hadrons_INCLUDE_DIR})
endif()

if(Hadrons_FOUND)
  execute_process(
    COMMAND ${Hadrons_CONFIG} --cxxflags OUTPUT_VARIABLE Hadrons_CXXFLAGS 
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  separate_arguments(Hadrons_CXXFLAGS UNIX_COMMAND "${Hadrons_CXXFLAGS}")
  execute_process(
    COMMAND ${Hadrons_CONFIG} --ldflags OUTPUT_VARIABLE Hadrons_LDFLAGS 
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  separate_arguments(Hadrons_LDFLAGS UNIX_COMMAND "${Hadrons_LDFLAGS}")
  execute_process(
    COMMAND ${Hadrons_CONFIG} --libs OUTPUT_VARIABLE Hadrons_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  separate_arguments(Hadrons_LIBS UNIX_COMMAND "${Hadrons_LIBS}")
endif()

if(Hadrons_FOUND AND NOT TARGET Hadrons::Hadrons)
  add_library(Hadrons::Hadrons UNKNOWN IMPORTED)
  set_target_properties(Hadrons::Hadrons PROPERTIES
    IMPORTED_LOCATION "${Hadrons_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${Hadrons_INCLUDE_DIR}"
    INTERFACE_COMPILE_OPTIONS "${Hadrons_CXXFLAGS}"
    INTERFACE_LINK_OPTIONS "${Hadrons_LDFLAGS};${Hadrons_LIBS}"
  )
endif()

mark_as_advanced(
  Hadrons_INCLUDE_DIR
  Hadrons_LIBRARY
  Hadrons_CONFIG
  Hadrons_CXXFLAGS
  Hadrons_LDFLAGS
  Hadrons_LIBS
)
