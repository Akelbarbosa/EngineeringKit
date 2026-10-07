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
| Force | pound-force, kip | `100.lbf`, `2.kip` |
| Torque | lbf·in, lbf·ft, kip·in, kip·ft | `12.lbfInch`, `1.lbfFoot`, `12.kipInch`, `1.kipFoot` |
| Mass density | lbm/ft³, lbm/in³ | `1.lbmPerCubicFoot`, `1.lbmPerCubicInch` |

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
- `Torque`: N·m, kN·m, lbf·in, lbf·ft, kip·in, and kip·ft
- `Density`: kg/m³, g/cm³, lbm/ft³, and lbm/in³
- Comparison, addition, subtraction, and scalar arithmetic
- `Force * Length` and `Length * Force` produce `Torque`

The force–length product assumes a perpendicular lever arm. These quantities
are signed scalars; the product does not calculate vector direction or angles.

## Project structure

EngineeringKit exposes one library module. Each physical quantity keeps its
value type, unit enum, and numeric shorthand together:

```text
Sources/
  EngineeringKit/
    Quantities/
      Force/      # Force.swift, ForceUnit.swift, Force+Literals.swift
      Length/     # Length.swift, LengthUnit.swift, Length+Literals.swift
      Torque/     # Torque.swift, TorqueUnit.swift, Torque+Literals.swift
      Density/    # Density.swift, DensityUnit.swift, Density+Literals.swift
      Operations/ # Relationships such as Force × Length → Torque
  EngineeringKitDemo/
Tests/
  EngineeringKitTests/
    Quantities/
      Force/
      Length/
      Torque/
      Density/
      Operations/
      QuantityLiteralsTests.swift
      EnglishUnitsTests.swift
```

New quantities follow this layout. Cross-quantity operators live in
`Quantities/Operations`, keeping conversions and same-quantity arithmetic
within their own type. Tests follow the same grouping, with a shared suite
checking numeric shorthand across quantities.

As the roadmap is implemented, `Geometry`, `Materials`, and `Mechanics` will
be added beside `Quantities`. Geometry and materials use the quantity types;
mechanics builds on quantities, geometry, and materials. The quantity layer
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
- [ ] Second moment of area
- [ ] Section modulus

### 0.2 — Geometry

- Rectangular sections
- Circular sections
- Section properties

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
