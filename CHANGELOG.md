# Changelog

## 0.1.0

Initial public release of the quantities and geometry foundation.

- Typed Force, Length, Area, Torque, Density, SecondMomentOfArea, and elastic
  SectionModulus with SI storage and metric/inch-pound conversions.
- Integer and floating-point shorthand, including `2.knewton` and `12.inch`.
- Typed force-length, area-length, and section-modulus operations.
- Solid and hollow rectangular/circular sections with area, centroid, second
  moments, elastic moduli, polar area moment, radii of gyration, and parallel axes.
- Recoverable errors for invalid geometry dimensions and offsets.
- Swift 6.0 minimum tools version, iOS 16 and macOS 13 deployment targets.
- Automated Linux and Apple compatibility checks, a separate package consumer,
  and a SwiftUI consumer compilation check.

Materials and mechanics are planned. Rectangular tubes assume sharp corners;
composite sections, catalog profiles, plastic properties, and general torsion
constants are not implemented. Calculations retain Double precision/range limits.
