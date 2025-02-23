cmake_minimum_required(VERSION 3.23)
if(${CMAKE_VERSION} VERSION_LESS 3.23)
cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
else()
cmake_policy(VERSION 3.23)
endif()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/platforms-toolchain/")

# ------ CROSS-COMPILE CONFIG ------
if(UNIX AND NOT ANDROID AND NOT APPLE)
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  message(STATUS "Ready for LINUX.")
  set(LINUX TRUE)
  set(PLATFORM_OS "Linux")
  set(OS_ARCHITECTURES ${CMAKE_SYSTEM_PROCESSOR})
include(linux-toolchain)
if(linux-toolchain)
    return()
endif()
set(linux-toolchain ON)
else()
  message(STATUS "Ready for Unix, BSDs...")
  set(UNIX TRUE)
  set(PLATFORM_OS "Unix")
  set(OS_ARCHITECTURES ${CMAKE_SYSTEM_PROCESSOR})
include(unix-toolchain)
if(unix-toolchain)
    return()
endif()
set(unix-toolchain ON)
endif()
elseif(APPLE)
set(APPLE TRUE)
message(STATUS "Ready for Apple Silicon.")
if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
    message(STATUS "Ready for iOS.")
    set(IOS TRUE)
    set(PLATFORM_OS "iOS")
    set(OS_ARCHITECTURES ${CMAKE_OSX_ARCHITECTURES})
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin" AND NOT CMAKE_SYSTEM_NAME STREQUAL "iOS")
set(MACOSX TRUE)
    message(STATUS "Ready for macOS.")
    set(MACOSX TRUE)
    set(PLATFORM_OS "macOS")
    set(OS_ARCHITECTURES ${CMAKE_SYSTEM_PROCESSOR})
include(macos-toolchain)
if(macos-toolchain)
  return()
endif()
set(macos-toolchain ON)
endif()
elseif(WIN32)
set(WINDOWS TRUE)
message(STATUS "Ready for Windows.")
include(windows-toolchain)
if(windows-toolchain)
  return()
endif()
set(windows-toolchain ON)
elseif(ANDROID)
    message(STATUS "Ready for Android.")
    set(ANDROID TRUE)
    set(PLATFORM_OS "Android")
    set(OS_ARCHITECTURES ${CMAKE_SYSTEM_PROCESSOR})
include(android-toolchain)
if(android-toolchain)
  return()
endif()
set(android-toolchain ON)
endif()
