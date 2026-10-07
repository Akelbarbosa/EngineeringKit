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
- Solid rectangular sections with typed area, centroid, centroidal second moments, and elastic section moduli
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
      Sections/   # RectangularSection and SectionGeometryError
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
      Sections/   # RectangularSectionTests
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
- [ ] Circular sections
- [ ] Additional section properties and shapes

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

- Swift 6+
- Foundation

## License

EngineeringKit is available under the MIT License.
