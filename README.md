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
`.millimeter`, `.newtonMeter`, and `.knewtonMeter`. For example:

```swift
let force = 2.knewton
let leverArm = 500.millimeter
let moment = force * leverArm // 1 kN·m
let fractionalForce = 2.5.knewton
```

The explicit `init(value:unit:)` API remains available. Numeric shorthand
converts its input to `Double`, matching the quantities' internal representation.

## Current capabilities

- `Force`: newtons and kilonewtons
- `Length`: meters and millimeters
- `Torque`: newton-meters and kilonewton-meters
- Comparison, addition, subtraction, and scalar arithmetic
- `Force * Length` and `Length * Force` produce `Torque`

The force–length product assumes a perpendicular lever arm. These quantities
are signed scalars; the product does not calculate vector direction or angles.

## Roadmap

### 0.1 — Units

- Force
- Torque
- Density
- Second moment of area
- Section modulus

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
