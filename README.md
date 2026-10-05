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
let force = 10.kilonewtons
let distance = 2.meters

let moment = force * distance
```

The API should make engineering calculations expressive while preventing incompatible quantities from being mixed accidentally.

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
