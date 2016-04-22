cmake_minimum_required(VERSION 2.6)
cmake_policy(VERSION 2.6)

project(openssl_mingw)

# Set default build type, common compiler flags, etc
include("set_compiler_flags.txt" NO_POLICY_SCOPE)

if (MINGW AND NOT IS_DIRECTORY "c:/openssl")
  message("Downloading the openssl source and building libcrypto")

  set(OpenSSLVersionBase 1.0.1)
  set(OpenSSLVersion ${OpenSSLVersionBase}f)
  set(OpenSSLSHA1 9ef09e97dfc9f14ac2c042f3b7e301098794fc0f)

  # Create build folder name derived from version
  string(REGEX REPLACE "beta\\.([0-9])$" "beta\\1" OpenSSLFolderName ${OpenSSLVersion})
  string(REPLACE "." "_" OpenSSLFolderName ${OpenSSLFolderName})
  set(OpenSSLFolderName openssl_${OpenSSLFolderName})

  set(OpenSSLCacheDir ${CMAKE_BINARY_DIR})

  # Set up the full path to the source directory
  set(OpenSSLSourceDir "${OpenSSLFolderName}_${CMAKE_CXX_COMPILER_ID}_${CMAKE_CXX_COMPILER_VERSION}")
  string(REPLACE "." "_" OpenSSLSourceDir ${OpenSSLSourceDir})
  set(OpenSSLSourceDir "${OpenSSLCacheDir}/${OpenSSLSourceDir}")

  set(ZipFilePath "${OpenSSLCacheDir}/${OpenSSLFolderName}.tar.gz")
  if(NOT EXISTS ${ZipFilePath})
    message(STATUS "Downloading OpenSSL ${OpenSSLVersion} to ${OpenSSLCacheDir}")
  endif()
  file(DOWNLOAD https://www.openssl.org/source/old/${OpenSSLVersionBase}/openssl-${OpenSSLVersion}.tar.gz
     ${ZipFilePath}
     STATUS Status
     SHOW_PROGRESS
     EXPECTED_HASH SHA1=${OpenSSLSHA1}
     )

  # Extract openssl if required
  string(FIND "${Status}" "returning early" Found)
  if(Found LESS "0" OR NOT IS_DIRECTORY "${OpenSSLSourceDir}")
    set(OpenSSLExtractFolder "${OpenSSLCacheDir}/openssl_unzip")
    file(REMOVE_RECURSE ${OpenSSLExtractFolder})
    file(MAKE_DIRECTORY ${OpenSSLExtractFolder})
    file(COPY ${ZipFilePath} DESTINATION ${OpenSSLExtractFolder})
    message(STATUS "Extracting openssl ${OpenSSLVersion} to ${OpenSSLExtractFolder}")
    execute_process(COMMAND ${CMAKE_COMMAND} -E tar zxf ${OpenSSLFolderName}.tar.gz
                    WORKING_DIRECTORY ${OpenSSLExtractFolder}
                    RESULT_VARIABLE Result
                    )
    if(NOT Result EQUAL "0")
      message(FATAL_ERROR "Failed extracting openssl ${OpenSSLVersion} to ${OpenSSLExtractFolder}")
    endif()
    file(REMOVE ${OpenSSLExtractFolder}/${OpenSSLFolderName}.tar.gz)

    # Get the path to the extracted folder
    file(GLOB ExtractedDir "${OpenSSLExtractFolder}/*")
    list(LENGTH ExtractedDir n)
    if(NOT n EQUAL "1" OR NOT IS_DIRECTORY ${ExtractedDir})
      message(FATAL_ERROR "Failed extracting openssl ${OpenSSLVersion} to ${OpenSSLExtractFolder}")
    endif()
    file(RENAME ${ExtractedDir} ${OpenSSLSourceDir})
    file(REMOVE_RECURSE ${OpenSSLExtractFolder})
  endif()

  # Build openssl if required
  message(STATUS "Configuring openssl")
  set(OpenSSLConfigure bash -c './config shared --openssldir=c:/openssl')

  message("Executing command '${OpenSSLConfigure}' in working dir ${OpenSSLSourceDir}...")
  #set(ENV{CPPFLAGS} -DWINVER=0x0501)
  execute_process(COMMAND ${OpenSSLConfigure} WORKING_DIRECTORY ${OpenSSLSourceDir}
                  RESULT_VARIABLE Result OUTPUT_VARIABLE Output ERROR_VARIABLE Error)
  if(NOT Result EQUAL "0")
    message(FATAL_ERROR "Failed running '${OpenSSLConfigure}': '${Result}' '${Output}'\n'${Error}'\n")
  endif()

  # Build openssl and install in C:\openssl
  set(OpenSSLInstall make -j1 install)
  message("Executing command '${OpenSSLInstall}' in working dir ${OpenSSLSourceDir}...")
  execute_process(COMMAND ${OpenSSLInstall} WORKING_DIRECTORY ${OpenSSLSourceDir}
                  RESULT_VARIABLE Result OUTPUT_VARIABLE Output ERROR_VARIABLE Error)
  if(NOT Result EQUAL "0")
    message(FATAL_ERROR "Failed running '${OpenSSLInstall}': '${Result}' '${Output}'\n'${Error}'\n")
  endif()
endif()

if (MINGW)
  find_package(OpenSSL REQUIRED)
  find_path(OPENSSL_INCLUDE_DIR openssl/md5.h)
  find_library(CRYPTO_LIBRARY_PATH NAMES crypto)
  if (OpenSSL_FOUND)
    message(STATUS "dxcpp CMakeLists.txt says: OpenSSL found!")
    message(STATUS "\t** OPENSSL_INCLUDE_DIR = \"${OPENSSL_INCLUDE_DIR}\"")
    message(STATUS "\t** OPENSSL_LIBRARIES = \"${OPENSSL_LIBRARIES}\"")
  else()
    message(FATAL_ERROR "\ndxcpp says: Unable to find OpenSSL. OPENSSL_INCLUDE_DIR = \"${OPENSSL_INCLUDE_DIR}\", OPENSSL_LIBRARIES = \"${OPENSSL_LIBRARIES}\",")
  endif()
else()
  find_path(OPENSSL_INCLUDE_DIR openssl/md5.h)
  find_library(CRYPTO_LIBRARY_PATH NAMES crypto)

  if (OPENSSL_INCLUDE_DIR AND CRYPTO_LIBRARY_PATH)
    message(STATUS "dxcpp CMakeLists.txt says: libcrypto, and openssl/md5.h found!")
    message(STATUS "\t** OPENSSL_INCLUDE_DIR = \"${OPENSSL_INCLUDE_DIR}\"")
    message(STATUS "\t** CRYPTO_LIBRARY_PATH = \"${CRYPTO_LIBRARY_PATH}\"")
  else()
    message(FATAL_ERROR "\ndxcpp says: Unable to find 'libcrypto' and/or 'openssl/md5.h'. OPENSSL_INCLUDE_DIR = \"${OPENSSL_INCLUDE_DIR}\", CRYPTO_LIBRARY_PATH = \"${CRYPTO_LIBRARY_PATH}\"")
  endif()
endif()

include_directories(BEFORE ${OPENSSL_INCLUDE_DIR})

if (MINGW)
  target_link_libraries(dxcpp dxhttp dxjson ${OPENSSL_LIBRARIES} ${Boost_LIBRARIES})
endif()
