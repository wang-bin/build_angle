set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
if(POLICY CMP0063) # visibility. since 3.3
  cmake_policy(SET CMP0063 NEW)
endif()
 
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_C_VISIBILITY_PRESET hidden)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
 
if(WIN32 AND NOT WINDOWS_STORE)
    set(WINDOWS_DESKTOP 1)
else()
    set(WINDOWS_DESKTOP 0)
endif()
 
if(MSVC)
    link_libraries(-opt:ref)
    if(CMAKE_CXX_SIMULATE_ID MATCHES MSVC)
        add_compile_options(-GR- -Xclang -Oz)
        #add_compile_options(-flto)
    else()
        set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -guard:cf -LTCG")
    endif()
else()
    add_compile_options(-fno-rtti -fno-exceptions)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
    #add_compile_options(-flto=thin) # lld-link: error: lto.tmp: undefined symbol: ldexpf
endif()

