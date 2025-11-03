# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\ProyectoPresupuestoBD_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\ProyectoPresupuestoBD_autogen.dir\\ParseCache.txt"
  "ProyectoPresupuestoBD_autogen"
  )
endif()
