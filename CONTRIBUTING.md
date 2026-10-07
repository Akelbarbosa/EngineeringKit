# Contributing to EngineeringKit

Use Swift 6.0 or later. The library has no external package dependencies.

## Development

```sh
swift build
swift test
swift run EngineeringKitDemo
swift run --package-path Examples/PackageConsumer PackageConsumer
```

On macOS with full Xcode selected, also run `bash scripts/check-apple.sh`.
It checks compilation and linkage for macOS 13 and iOS 16 deployment targets;
it does not establish runtime testing on those OS versions.

Keep quantities grouped under `Sources/EngineeringKit/Quantities`, shared
dimensional operators in `Quantities/Operations`, and geometry in `Geometry`.
Mirror source organization in tests. Keep the library independent of SwiftUI.

Use the existing filename/project/author/date header for new Swift files and
document public declarations in English. Preserve creation dates in existing
files. Write tests for numerical reference values, validation, or other meaningful
behavior; compare converted floating-point values with a suitable tolerance.

## Pull requests

Explain the problem, resulting behavior, and validation. Add a changelog entry
for user-visible changes and update examples when APIs change. All compatibility
checks should pass before merge. Discuss new public API names and any changes
to unit definitions, axes, numeric behavior, or platform requirements.

## Versions

Tags use semantic versions such as `0.1.0`. During the 0.x series, breaking API
changes belong in a new minor version and must be described in the changelog;
patch releases preserve the public API. After 1.0, breaking changes require a
major version. Existing tags are never moved to another commit.

Before a release, require green CI on the intended commit, create its tag and
GitHub release, then resolve that exact tag from a clean external consumer.
Report only platforms and compilers actually checked, and distinguish compile
checks from runtime tests. Do not commit credentials, build products, or local
assistant instruction files.
