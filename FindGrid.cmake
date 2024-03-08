find_path(Grid_INCLUDE_DIR
  NAMES Grid/Grid.h
)
find_library(Grid_LIBRARY
  NAMES Grid
)
find_program(Grid_CONFIG 
  NAMES grid-config
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Grid
  FOUND_VAR Grid_FOUND
  REQUIRED_VARS
    Grid_LIBRARY
    Grid_INCLUDE_DIR
    Grid_CONFIG
  VERSION_VAR Grid_VERSION
)

if(Grid_FOUND)
  set(Grid_LIBRARIES ${Grid_LIBRARY})
  set(Grid_INCLUDE_DIRS ${Grid_INCLUDE_DIR})
endif()

if(Grid_FOUND)
  execute_process(
    COMMAND ${Grid_CONFIG} --cxxflags OUTPUT_VARIABLE Grid_CXXFLAGS 
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  separate_arguments(Grid_CXXFLAGS UNIX_COMMAND "${Grid_CXXFLAGS}")
  execute_process(
    COMMAND ${Grid_CONFIG} --ldflags OUTPUT_VARIABLE Grid_LDFLAGS 
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  separate_arguments(Grid_LDFLAGS UNIX_COMMAND "${Grid_LDFLAGS}")
  execute_process(
    COMMAND ${Grid_CONFIG} --libs OUTPUT_VARIABLE Grid_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  separate_arguments(Grid_LIBS UNIX_COMMAND "${Grid_LIBS}")
endif()

if(Grid_FOUND AND NOT TARGET Grid::Grid)
  add_library(Grid::Grid UNKNOWN IMPORTED)
  set_target_properties(Grid::Grid PROPERTIES
    IMPORTED_LOCATION "${Grid_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${Grid_INCLUDE_DIR}"
    INTERFACE_COMPILE_OPTIONS "${Grid_CXXFLAGS}"
    INTERFACE_LINK_OPTIONS "${Grid_LDFLAGS};${Grid_LIBS}"
  )
endif()

mark_as_advanced(
  Grid_INCLUDE_DIR
  Grid_LIBRARY
  Grid_CONFIG
  Grid_CXXFLAGS
  Grid_LDFLAGS
  Grid_LIBS
)
