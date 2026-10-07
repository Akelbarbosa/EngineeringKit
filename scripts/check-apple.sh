#!/bin/bash
# Compile the public module and a SwiftUI consumer for the declared Apple minima.
# This checks SDK availability and linkage; it does not run an old OS simulator.
set -euo pipefail
repo_root="$(cd "$(dirname "$0")/.." && pwd)"
build_root="$(mktemp -d "${TMPDIR:-/tmp}/engineeringkit-apple.XXXXXX")"
trap 'rm -rf "$build_root"' EXIT
# Compile a stable snapshot so filesystem metadata updates cannot change inputs mid-build.
mkdir -p "$build_root/source"
cp -R "$repo_root/Sources/EngineeringKit" "$build_root/source/EngineeringKit"
cp -R "$repo_root/Examples/SwiftUI" "$build_root/source/SwiftUI"
sources=()
while IFS= read -r source; do
  sources+=("$source")
done < <(find "$build_root/source/EngineeringKit" -name '*.swift' -type f | sort)

compile_consumer() {
  local sdk_name="$1" target="$2" label="$3"
  local sdk_path out_dir
  sdk_path="$(xcrun --sdk "$sdk_name" --show-sdk-path)"
  out_dir="$build_root/$label"
  mkdir -p "$out_dir"
  xcrun --sdk "$sdk_name" swiftc -swift-version 6 -sdk "$sdk_path" -target "$target"     -module-cache-path "$build_root/module-cache-$label"     -parse-as-library -emit-library -emit-module -module-name EngineeringKit     "${sources[@]}" -emit-module-path "$out_dir/EngineeringKit.swiftmodule"     -o "$out_dir/libEngineeringKit.dylib"
  xcrun --sdk "$sdk_name" swiftc -swift-version 6 -sdk "$sdk_path" -target "$target"     -module-cache-path "$build_root/module-cache-$label"     -parse-as-library -I "$out_dir" -L "$out_dir" -lEngineeringKit     "$build_root/source/SwiftUI/GeometryView.swift"     "$build_root/source/SwiftUI/GeometryExampleApp.swift" -o "$out_dir/GeometryExample"
  echo "SwiftUI consumer compiled and linked: $label ($target)"
}

# Both Apple Silicon and Intel consumers are checked, plus an iOS device build.
compile_consumer macosx arm64-apple-macosx13.0 macos-arm64
compile_consumer macosx x86_64-apple-macosx13.0 macos-intel
compile_consumer iphonesimulator arm64-apple-ios16.0-simulator ios-simulator
compile_consumer iphoneos arm64-apple-ios16.0 ios-device
