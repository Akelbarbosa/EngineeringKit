//
//  SecondMomentOfArea.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// The second moment of a plane area about a specified axis, stored in m⁴.
///
/// This quantity is also called the area moment of inertia. It is distinct from
/// mass moment of inertia (mass × length²). The caller determines the reference
/// axis; this scalar type does not encode the axis or validate physical ranges.
public struct SecondMomentOfArea: Sendable, Equatable, Comparable {
    /// The canonical SI value used by conversions and arithmetic.
    private let valueInMetersToFourthPower: Double

    /// Creates a quantity by converting the supplied fourth-power unit to SI.
    public init(value: Double, unit: SecondMomentOfAreaUnit) {
        self.valueInMetersToFourthPower = value * unit.siConversionFactor
    }

    /// Returns the quantity expressed in the requested fourth-power unit.
    public func value(in unit: SecondMomentOfAreaUnit) -> Double {
        valueInMetersToFourthPower / unit.siConversionFactor
    }

    /// Orders quantities by their signed SI values.
    public static func < (lhs: SecondMomentOfArea, rhs: SecondMomentOfArea) -> Bool {
        lhs.valueInMetersToFourthPower < rhs.valueInMetersToFourthPower
    }

    /// Adds second moments about the same reference axis, in any supported units.
    public static func + (lhs: SecondMomentOfArea, rhs: SecondMomentOfArea) -> SecondMomentOfArea {
        SecondMomentOfArea(
            value: lhs.valueInMetersToFourthPower + rhs.valueInMetersToFourthPower,
            unit: .meterToFourthPower
        )
    }

    /// Subtracts second moments about the same reference axis, in any supported units.
    public static func - (lhs: SecondMomentOfArea, rhs: SecondMomentOfArea) -> SecondMomentOfArea {
        SecondMomentOfArea(
            value: lhs.valueInMetersToFourthPower - rhs.valueInMetersToFourthPower,
            unit: .meterToFourthPower
        )
    }

    /// Scales the second moment by a dimensionless value.
    public static func * (lhs: SecondMomentOfArea, rhs: Double) -> SecondMomentOfArea {
        SecondMomentOfArea(value: lhs.valueInMetersToFourthPower * rhs, unit: .meterToFourthPower)
    }

    /// Scales the second moment with the scalar on the left.
    public static func * (lhs: Double, rhs: SecondMomentOfArea) -> SecondMomentOfArea {
        rhs * lhs
    }

    /// Divides by a scalar, preserving Double behavior for zero divisors.
    public static func / (lhs: SecondMomentOfArea, rhs: Double) -> SecondMomentOfArea {
        SecondMomentOfArea(value: lhs.valueInMetersToFourthPower / rhs, unit: .meterToFourthPower)
    }
}
