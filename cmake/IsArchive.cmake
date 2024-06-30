# helper function to check wether a file is an archive
function(is_archive FILE_PATH RESULT)
    set(VALID_EXTENSIONS
        [[\.zip$]]
        [[\.tar\.gz$]]
        [[\.tgz$]]
        [[\.tar\.bz2$]]
        [[\.tar\.xz$]]
        [[\.tar$]]
        [[\.7z$]]
        [[\.rar$]]
    )
    get_filename_component(FILE_NAME ${FILE_PATH} NAME)
    string(TOLOWER "${FILE_NAME}" FILE_LOWER_CASE)

    foreach(EXTENSION ${VALID_EXTENSIONS})
        if(FILE_LOWER_CASE MATCHES "${EXTENSION}$")
            set(${RESULT} TRUE PARENT_SCOPE)
            return() # Exit the function once a match is found
        endif()
    endforeach()

    set(${RESULT} FALSE PARENT_SCOPE)
endfunction()
