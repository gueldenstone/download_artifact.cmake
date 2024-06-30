include(DownloadArtifact)

# Test cases
set(TEST_FILES
    "test.zip"
    "test.tar.gz"
    "test.tgz"
    "test.tar.bz2"
    "test.tar.xz"
    "test.tar"
    "test.7z"
    "test.rar"
    "test.txt"
    "test.doc"
    "archive.TAR.GZ"
    "ARCHIVE.TAR.XZ"
    "noextension"
)

# Expected results
set(EXPECTED_RESULTS
    TRUE
    TRUE
    TRUE
    TRUE
    TRUE
    TRUE
    TRUE
    TRUE
    FALSE
    FALSE
    TRUE
    TRUE
    FALSE
)

# Function to run a single test
function(run_test FILE_PATH EXPECTED_RESULT)
    is_archive(${FILE_PATH} RESULT)

    if(RESULT STREQUAL ${EXPECTED_RESULT})
        message(STATUS "Test passed for ${FILE_PATH}")
    else()
        message(FATAL_ERROR "Test failed for ${FILE_PATH}: expected ${EXPECTED_RESULT}, got ${RESULT}")
    endif()
endfunction()

# Loop through the test cases
list(LENGTH TEST_FILES NUM_TESTS)
math(EXPR NUM_TESTS "${NUM_TESTS} - 1")

foreach(INDEX RANGE 0 ${NUM_TESTS})
    list(GET TEST_FILES ${INDEX} FILE)
    list(GET EXPECTED_RESULTS ${INDEX} EXPECTED)
    run_test(${FILE} ${EXPECTED})
endforeach()
