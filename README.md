# EngineeringKit

EngineeringKit is a type-safe Swift library for engineering calculations, physical quantities, units, geometry, materials, and mechanics.

The goal of EngineeringKit is to provide reusable engineering tools while leveraging Swift's type system to reduce unit-related mistakes and make engineering calculations easier to read and maintain.

## Goals

- Type-safe engineering quantities
- SI-based internal calculations
- Unit conversion
- Engineering geometry
- Material properties
- Structural and mechanical calculations
- Well-tested numerical implementations
- No external dependencies

## Installation

In Xcode, choose **File → Add Package Dependencies**, enter
`https://github.com/Akelbarbosa/EngineeringKit.git`, and select version `0.1.0`
or a compatible later version. Add the **EngineeringKit** library product to
your app target.

For another Swift package, add:

```swift
dependencies: [
    .package(url: "https://github.com/Akelbarbosa/EngineeringKit.git", from: "0.1.0")
]
```

Then include `.product(name: "EngineeringKit", package: "EngineeringKit")` in
your target dependencies and use `import EngineeringKit`. The library has no
SwiftUI dependency; it can be called from SwiftUI, UIKit, AppKit, or console code.

## Compatibility

| Component | Declared support | Verification |
| --- | --- | --- |
| Compiler | Swift 6.0+ | CI: Swift 6.0.0 and 6.3.3 on Linux; Xcode 16.0 and 26.6 on macOS |
| macOS | 13+ | Unit tests on CI hosts; SwiftUI compile/link checks targeting macOS 13, arm64 and x86_64 |
| iOS | 16+ | SwiftUI compile/link checks targeting iOS 16, simulator and device |
| Linux | Ubuntu 22.04 CI | Build, unit tests, demo, and separate package consumer |

The current workflow is visible in [GitHub Actions](https://github.com/Akelbarbosa/EngineeringKit/actions).
Apple Swift 6.4 / Xcode 27 is also checked locally during release preparation.
Deployment targets and compiler versions are independent: using a new compiler
does not require the newest iOS or macOS. Oldest-OS runtime tests have not been
performed; compilation checks should not be interpreted as such. Other platforms
and compilers are not part of the initial verification matrix.

## API conventions

Quantities are immutable, Sendable value types with canonical SI storage. Raw
quantities accept signed and non-finite scalars, preserving Double arithmetic;
physical section constructors instead validate dimensions and relationships.
Exact equality compares stored values; use tolerances for converted results.
Axes are documented by each geometry model, not encoded in scalar moments.
`SectionModulus` denotes an elastic property, not volume, and `Density` denotes
mass per volume, not weight per volume. The original `hello()` scaffold remains
available for source compatibility and is not part of the calculation API.

The initial release is `0.1.0`. In the 0.x series, breaking changes use a new
minor version and are recorded in [CHANGELOG.md](CHANGELOG.md); patch versions
preserve APIs. See [CONTRIBUTING.md](CONTRIBUTING.md) for development and releases.

## Example

```swift
let force = 10.knewton
let distance = 2.meter

let moment = force * distance
print(moment.value(in: .kilonewtonMeter)) // 20
```

The API should make engineering calculations expressive while preventing incompatible quantities from being mixed accidentally.

## Numeric shorthand

Integer and floating-point values support `.newton`, `.knewton`, `.meter`,
`.millimeter`, `.newtonMeter`, `.knewtonMeter`, `.kgPerCubicMeter`, and
`.gPerCubicCentimeter`. For example:

```swift
let force = 2.knewton
let leverArm = 500.millimeter
let moment = force * leverArm // 1 kN·m
let fractionalForce = 2.5.knewton
let density = 1.gPerCubicCentimeter
print(density.value(in: .kilogramPerCubicMeter)) // 1000
```

The explicit `init(value:unit:)` API remains available. Numeric shorthand
converts its input to `Double`, matching the quantities' internal representation.

## English engineering units

The quantities support international inch-pound units alongside SI. Inputs can
be mixed freely; internal storage and arithmetic continue to use SI.

| Quantity | Units | Numeric shorthand |
| --- | --- | --- |
| Length | inch, foot, yard | `12.inch`, `1.foot`, `1.yard` |
| Area | in², ft² | `1.in2`, `1.ft2` |
| Force | pound-force, kip | `100.lbf`, `2.kip` |
| Torque | lbf·in, lbf·ft, kip·in, kip·ft | `12.lbfInch`, `1.lbfFoot`, `12.kipInch`, `1.kipFoot` |
| Mass density | lbm/ft³, lbm/in³ | `1.lbmPerCubicFoot`, `1.lbmPerCubicInch` |
| Second moment of area | in⁴, ft⁴ | `1.in4`, `1.ft4` |
| Elastic section modulus | in³, ft³ | `1.in3`, `1.ft3` |

```swift
let length = 12.inch
print(length.value(in: .millimeter)) // approximately 304.8
let moment = 2.kip * length
print(moment.value(in: .kipFoot)) // approximately 2
let mixedMoment = 100.lbf * 0.5.meter
```

`lbf` means pound-force and `lbm` means pound-mass. `Density` represents mass
per volume, not weight per volume. The foot is the international foot, not the
U.S. survey foot. These inch-pound units are shared by U.S. customary and British
imperial engineering usage; volume measures such as gallons are not implemented.

Conversion definitions follow [NIST SP 811, Appendix B](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication811e2008.pdf):
1 inch = 0.0254 m, 1 foot = 0.3048 m, 1 yard = 0.9144 m,
1 avoirdupois pound = 0.45359237 kg, and 1 lbf = 4.4482216152605 N.
Torque and density factors are derived from these definitions rather than rounded
tables. Calculations use `Double`; compare converted results with an appropriate
tolerance when floating-point rounding matters.

## Current capabilities

- `Force`: N, kN, lbf, and kip
- `Length`: m, mm, in, ft, and yd
- `Area`: m², mm², in², and ft²
- `Torque`: N·m, kN·m, lbf·in, lbf·ft, kip·in, and kip·ft
- `Density`: kg/m³, g/cm³, lbm/ft³, and lbm/in³
- `SecondMomentOfArea`: m⁴, mm⁴, in⁴, and ft⁴
- `SectionModulus`: m³, mm³, in³, and ft³
- Comparison, addition, subtraction, and scalar arithmetic
- `Length * Length` produces `Area`; `Area / Length` produces `Length`
- Solid and hollow rectangular/circular sections with typed area, centroid, second moments, and elastic section moduli
- Shared `PlaneSection` interface with polar area moment, radii of gyration, and parallel-axis calculations
- `Force * Length` and `Length * Force` produce `Torque`
- `SecondMomentOfArea / Length` produces `SectionModulus`
- `SectionModulus * Length` and `Length * SectionModulus` produce `SecondMomentOfArea`

The force–length product assumes a perpendicular lever arm. These quantities
are signed scalars; the product does not calculate vector direction or angles.

## Second moment of area

`SecondMomentOfArea` represents the area moment of inertia of a plane section
about a specified axis. Its dimension is length⁴; it is distinct from mass moment
of inertia. It stores values in m⁴ and supports comparison and scalar arithmetic.
The caller determines the reference axis, which is not encoded in this scalar
type. Addition and subtraction require a common reference axis. Geometry models
such as RectangularSection compute these values about documented axes.

```swift
let secondMoment = 10.in4
print(secondMoment.value(in: .millimeterToFourthPower)) // approximately 4162314.256
let metricSecondMoment = 2_000_000.mm4
let explicit = SecondMomentOfArea(value: 0.001, unit: .meterToFourthPower)
```

Both integers and decimals support `.m4`, `.mm4`, `.in4`, and `.ft4`. Conversion
factors are derived by raising the corresponding length factor to the fourth
power, following the second-moment units in [NIST SP 811](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication811e2008.pdf).
Like the other scalar types, this quantity does not enforce physical value ranges
or encode the axis. Floating-point conversion results should use a tolerance.

## Elastic section modulus

`SectionModulus` represents the elastic section modulus S = I / c, where I is the
second moment of area and c is the positive distance from that neutral axis to
the extreme fiber. This follows the [University of Illinois bending reference](https://mechref.engr.illinois.edu/sol/bending.html).
It stores m³ and remains a separate quantity from volume. Plastic section modulus
is not modeled by this elastic calculation.

```swift
let secondMoment = 10.in4
let extremeFiberDistance = 2.inch
let modulus = secondMoment / extremeFiberDistance
print(modulus.value(in: .cubicInch)) // approximately 5
let recovered = modulus * extremeFiberDistance // approximately 10 in⁴
let explicit = SectionModulus(value: 40_000, unit: .cubicMillimeter)
```

Integers and decimals support `.m3`, `.mm3`, `.in3`, and `.ft3`. Cubic-unit
conversion factors use the cube of the corresponding length factor. The caller
is responsible for the reference axis, fiber, and physical input ranges. Raw
operators preserve `Double` behavior, including infinity or NaN on division by
zero. Adding scalar moduli does not compute the modulus of a combined section.

## Rectangular sections

`RectangularSection` models a solid rectangle, with width b along x and height h
along y. Its local origin is the lower-left corner, so the centroid is (b/2, h/2).
The second moments and elastic section moduli use axes passing through that
centroid: Ix = bh³/12, Iy = hb³/12, Sx = Ix/(h/2), and Sy = Iy/(b/2).
The centroidal second-moment formulas follow [Engineering Statics](https://engineeringstatics.org/MOI-common-shapes.html).

```swift
let section = try RectangularSection(width: 2.inch, height: 6.inch)
print(section.area.value(in: .squareInch)) // approximately 12
print(section.secondMomentOfAreaX.value(in: .inchToFourthPower)) // approximately 36
print(section.secondMomentOfAreaY.value(in: .inchToFourthPower)) // approximately 4
print(section.sectionModulusX.value(in: .cubicInch)) // approximately 12
print(section.sectionModulusY.value(in: .cubicInch)) // approximately 4
let mixed = try RectangularSection(width: 2.inch, height: 152.4.millimeter)
```

The initializer throws `SectionGeometryError.invalidDimension(name:)` for zero,
negative, or non-finite width or height. This validation belongs to physical
geometry; raw scalar quantities continue to preserve their existing arithmetic
behavior. Results use Double, including its numeric range limits.

`Area` supplies `.m2`, `.mm2`, `.in2`, and `.ft2` shorthand for integers and
decimals. Area conversions square the corresponding length factor. Products of
scalar lengths produce Area; dividing Area by Length recovers Length.

## Circular and hollow sections

Geometry includes `CircularSection(diameter:)`,
`HollowCircularSection(outerDiameter:innerDiameter:)`, and
`HollowRectangularSection(width:height:wallThickness:)`. All four section types
conform to `PlaneSection`. Their origin is the lower-left corner of the outer
bounding rectangle; x is horizontal and y is vertical. A hollow section has a
concentric opening. Rectangular tubes have uniform walls and sharp corners;
catalog sections with rounded corners need a different model.

```swift
let circle = try CircularSection(diameter: 2.inch)
let pipe = try HollowCircularSection(outerDiameter: 4.inch, innerDiameter: 50.8.millimeter)
let tube = try HollowRectangularSection(width: 8.inch, height: 6.inch, wallThickness: 1.inch)
print(pipe.area.value(in: .squareInch)) // approximately 3π
print(tube.secondMomentOfAreaX.value(in: .inchToFourthPower)) // approximately 112
print(circle.radiusOfGyrationX.value(in: .inch)) // approximately 0.5
```

For a solid circle, A = πd²/4 and Ix = Iy = πd⁴/64. For a circular tube,
A = π(D²-d²)/4 and Ix = Iy = π(D⁴-d⁴)/64. Hollow rectangular properties
subtract the concentric opening: A = bh-bi×hi, Ix = (bh³-bi×hi³)/12,
and Iy = (hb³-hi×bi³)/12, with bi = b-2t and hi = h-2t. The code factors
these differences to reduce cancellation for thin walls. Elastic section moduli
use the **outer** extreme-fiber distance. The circular formulas and subtractive
construction follow [Engineering Statics](https://engineeringstatics.org/parallel-axis-theorem-section.html).

Dimensions must be positive and finite. Inner diameter must be smaller than
outer diameter; rectangular thickness must leave a positive, representable
opening in both directions. Invalid relationships throw
`invalidDiameterRelationship` or `invalidWallThickness`. Use a solid section
instead of a tube with zero inner diameter. Calculations retain Double's range
and precision limits, including potential underflow or overflow at extreme sizes.

## Common section properties

`PlaneSection` supplies centroidal `polarMomentOfArea` (J = Ix + Iy),
`radiusOfGyrationX`, and `radiusOfGyrationY` (k = √(I/A)). The polar moment
is a geometric property; it is **not** the Saint-Venant torsion constant of a
general cross-section. Radius formulas follow
[Engineering Statics](https://engineeringstatics.org/radius-of-gyration-sec.html).

```swift
let rectangle = try RectangularSection(width: 2.inch, height: 6.inch)
let atBase = try rectangle.secondMomentOfAreaX(offsetY: (-3).inch)
let atLeftEdge = try rectangle.secondMomentOfAreaY(offsetX: (-1).inch)
print(atBase.value(in: .inchToFourthPower)) // approximately 144
print(atLeftEdge.value(in: .inchToFourthPower)) // approximately 16
```

These methods use the [parallel-axis theorem](https://engineeringstatics.org/parallel-axis-theorem-section.html),
I = Icentroid + A×offset². Offsets are measured **from the centroidal axis**,
not from the local origin: x-axis displacement is along y, and y-axis displacement
is along x. Zero and negative offsets are valid; non-finite offsets throw
`SectionGeometryError.nonFiniteOffset(name:)`. Shifted moments do not change the
centroidal elastic section modulus or radii of gyration.

## Build and validation

From the repository root, use Swift Package Manager:

```sh
swift build
swift test
swift run EngineeringKitDemo
swift run --package-path Examples/PackageConsumer PackageConsumer
```

The demo exercises quantities, mixed units, solid and hollow sections, radii of
gyration, and parallel-axis moments. Tests cover reference values, geometric
scaling, symmetry, unit conversions, and invalid dimensions and offsets.

For Apple integration, run `bash scripts/check-apple.sh` with full Xcode selected.
The SwiftUI example sources in `Examples/SwiftUI` can also be added to a small
iOS or macOS app that depends on the EngineeringKit package.

## Project structure

EngineeringKit exposes one library module. Each physical quantity keeps its
value type, unit enum, and numeric shorthand together:

```text
Sources/
  EngineeringKit/
    Quantities/
      Force/      # Force.swift, ForceUnit.swift, Force+Literals.swift
      Length/     # Length.swift, LengthUnit.swift, Length+Literals.swift
      Area/       # Area.swift, AreaUnit.swift, Area+Literals.swift
      Torque/     # Torque.swift, TorqueUnit.swift, Torque+Literals.swift
      Density/    # Density.swift, DensityUnit.swift, Density+Literals.swift
      SecondMomentOfArea/ # Type, fourth-power units, and numeric shorthand
      SectionModulus/ # Type, cubic units, and numeric shorthand
      Operations/ # Relationships between quantities
    Geometry/
      Sections/   # PlaneSection, solid/hollow sections, and geometry errors
  EngineeringKitDemo/
Tests/
  EngineeringKitTests/
    Quantities/
      Force/
      Length/
      Area/
      Torque/
      Density/
      SecondMomentOfArea/
      SectionModulus/
      Operations/
      QuantityLiteralsTests.swift
      EnglishUnitsTests.swift
    Geometry/
      Sections/   # Shape and shared section-property tests
```

New quantities follow this layout. Cross-quantity operators live in
`Quantities/Operations`, keeping conversions and same-quantity arithmetic
within their own type. Tests follow the same grouping, with a shared suite
checking numeric shorthand across quantities.

`Geometry` sits beside `Quantities` and builds on the quantity types. As the
roadmap is implemented, `Materials` and `Mechanics` will be added alongside them.
Mechanics builds on quantities, geometry, and materials. The quantity layer
must stay independent of those higher-level models and of UI frameworks.

This organization preserves `import EngineeringKit` and all existing quantity
APIs, including numeric shorthand. It does not require additional Swift targets.

## Roadmap

### 0.1 — Units

- [x] Force
- [x] Length
- [x] Torque
- [x] Density
- [x] English engineering units for the implemented quantities
- [x] Second moment of area
- [x] Section modulus

### 0.2 — Geometry

- [x] Area quantity and square-unit conversions
- [x] Solid rectangular sections and centroidal properties
- [x] Solid circular sections
- [x] Hollow circular and rectangular sections
- [x] Shared section interface, polar area moment, and radii of gyration
- [x] Parallel-axis moments and geometry validation

This completes the initial geometry milestone. Composite sections, rotations,
plastic properties, and catalog profiles remain possible future extensions.

### 0.3 — Materials

- Material model
- Common engineering materials

### 0.4 — Mechanics

- Cantilever beams
- Point loads
- Support reactions
- Shear and bending moment
- Stress
- Deflection

## Design principles

EngineeringKit aims to:

- Prefer strongly typed quantities over raw `Double` values
- Use SI units internally
- Reuse Foundation's `Measurement` APIs when appropriate
- Keep engineering calculations independent from UI frameworks
- Make numerical behavior testable and predictable

## Requirements

- Swift 6.0 or later
- iOS 16+ or macOS 13+ for Apple consumers; the calculation library also targets Linux
- Foundation

## License

EngineeringKit is available under the MIT License.
