//
//  SectionModulus.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// The elastic section modulus about a specified axis, stored in m³.
///
/// For elastic bending, S = I / c, with c the positive distance to an extreme
/// fiber measured from the same neutral axis as I. This is a section property,
/// distinct from volume despite sharing the length³ dimension. The reference
/// axis and fiber are not encoded, and this scalar type does not validate ranges.
public struct SectionModulus: Sendable, Equatable, Comparable {
    /// The canonical SI value used by conversions and arithmetic.
    private let valueInCubicMeters: Double

    /// Creates a quantity by converting the supplied cubic unit to SI.
    public init(value: Double, unit: SectionModulusUnit) {
        self.valueInCubicMeters = value * unit.siConversionFactor
    }

    /// Returns the quantity expressed in the requested cubic unit.
    public func value(in unit: SectionModulusUnit) -> Double {
        valueInCubicMeters / unit.siConversionFactor
    }

    /// Orders quantities by their signed SI values.
    public static func < (lhs: SectionModulus, rhs: SectionModulus) -> Bool {
        lhs.valueInCubicMeters < rhs.valueInCubicMeters
    }

    /// Adds scalar modulus values; this does not calculate a combined section property.
    public static func + (lhs: SectionModulus, rhs: SectionModulus) -> SectionModulus {
        SectionModulus(
            value: lhs.valueInCubicMeters + rhs.valueInCubicMeters,
            unit: .cubicMeter
        )
    }

    /// Subtracts scalar modulus values after normalizing their units.
    public static func - (lhs: SectionModulus, rhs: SectionModulus) -> SectionModulus {
        SectionModulus(
            value: lhs.valueInCubicMeters - rhs.valueInCubicMeters,
            unit: .cubicMeter
        )
    }

    /// Scales the section modulus by a dimensionless value.
    public static func * (lhs: SectionModulus, rhs: Double) -> SectionModulus {
        SectionModulus(value: lhs.valueInCubicMeters * rhs, unit: .cubicMeter)
    }

    /// Scales the section modulus with the scalar on the left.
    public static func * (lhs: Double, rhs: SectionModulus) -> SectionModulus {
        rhs * lhs
    }

    /// Divides by a scalar, preserving Double behavior for zero divisors.
    public static func / (lhs: SectionModulus, rhs: Double) -> SectionModulus {
        SectionModulus(value: lhs.valueInCubicMeters / rhs, unit: .cubicMeter)
    }
}
