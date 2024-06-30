# Download Artifacts with CMake

This is a simple cmake script which downloads an artifact from a URL. It adds caching on local disk to support offline builds.

To make use of this simply add the `DownloadArtifact.cmake` script to your repository. You can also make use of [CPM](https://github.com/cpm-cmake/CPM.cmake) to dynamically download this module like so:

```
CPMAddPackage("gh:gueldenstone/download_artifact.cmake#v0.0.2")
```

To run the tests configure with `RUN_TESTS=ON`.
