set(ARTIFACT_CACHE_DIR "" CACHE PATH "Directory to store downloaded files")

include(IsArchive)

function(download_artifact NAME)
    set(options "NO_CACHE")
    set(oneValueArgs "URL" "URL_HASH" "USER" "PASS")
    set(multiValueArgs "")
    cmake_parse_arguments(PARSE_ARGV 1 "DL" "${options}" "${oneValueArgs}"
        "${multiValueArgs}")

    set(OUTPUT_DIR "${CMAKE_BINARY_DIR}/_deps/${NAME}")
    is_archive(${DL_URL} IS_ARCHIVE)

    if(NOT DL_NO_CACHE)
        set(DEFAULT_CACHE_DIR "${CMAKE_BINARY_DIR}/_deps/.download_cache")

        if(ARTIFACT_CACHE_DIR STREQUAL "")
            set(ARTIFACT_CACHE_DIR ${DEFAULT_CACHE_DIR})
        endif()

        # use the hash of the url as cache id
        string(SHA256 CACHE_ID ${DL_URL})

        # extract the file name from the url
        get_filename_component(FILE_NAME ${DL_URL} NAME)

        # create the cache folder
        set(CACHE_FOLDER "${ARTIFACT_CACHE_DIR}/${CACHE_ID}")
        file(MAKE_DIRECTORY ${CACHE_FOLDER})

        # set the cache file path
        set(CACHE_FILE "${CACHE_FOLDER}/${FILE_NAME}")

        if(NOT EXISTS ${CACHE_FILE})
            # Download the file
            message(STATUS "Downloading ${DL_URL}...")
            set(FILE_DOWNLOAD_ARGS "")

            if(DL_USER)
                list(APPEND FILE_DOWNLOAD_ARGS "USERPWD;${DL_USER}:${DL_PASS}")
            endif()

            if(DL_URL_HASH)
                list(APPEND FILE_DOWNLOAD_ARGS "EXPECTED_HASH;${DL_URL_HASH}")
            endif()

            file(DOWNLOAD ${DL_URL} ${CACHE_FILE} SHOW_PROGRESS ${FILE_DOWNLOAD_ARGS})
        else()
            message(STATUS "Using cached file ${CACHE_FILE}")
        endif()

        file(MAKE_DIRECTORY ${OUTPUT_DIR})

        if(IS_ARCHIVE)
            message(STATUS "Extracting ${CACHE_FILE} archive...")
            file(ARCHIVE_EXTRACT INPUT ${CACHE_FILE} DESTINATION ${OUTPUT_DIR})
        else()
            message(STATUS "Copying ${CACHE_FILE} to ${OUTPUT_DIR}")
            file(COPY ${CACHE_FILE} DESTINATION ${OUTPUT_DIR})
        endif()
    endif()
endfunction()
