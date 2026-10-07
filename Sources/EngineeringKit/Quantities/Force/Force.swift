//
//  Force.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 5/10/26.
//

import Foundation

/// A signed scalar force stored internally in newtons.
public struct Force: Sendable, Equatable, Comparable {
    /// The canonical SI value used by conversions and arithmetic.
    private let valueInNewtons: Double

    /// Creates a quantity by converting the supplied unit to SI.
    public init(value: Double, unit: ForceUnit) {
        self.valueInNewtons = value * unit.siConversionFactor
    }

    /// Returns the quantity expressed in the requested unit.
    public func value(in unit: ForceUnit) -> Double {
        return valueInNewtons / unit.siConversionFactor
    }

    /// Compares exact SI values; floating-point rounding can affect equality.
    public static func == (lhs: Force, rhs: Force) -> Bool {
        lhs.valueInNewtons == rhs.valueInNewtons
    }

    /// Orders quantities by their signed SI values.
    public static func < (lhs: Force, rhs: Force) -> Bool {
        lhs.valueInNewtons < rhs.valueInNewtons
    }

    /// Adds quantities, allowing different input units.
    public static func + (lhs: Force, rhs: Force) -> Force {
        Force(
            value: lhs.value(in: .newton) + rhs.value(in: .newton),
            unit: .newton
        )
    }

    /// Subtracts quantities, allowing different input units.
    public static func - (lhs: Force, rhs: Force) -> Force {
        Force(
            value: lhs.value(in: .newton) - rhs.value(in: .newton),
            unit: .newton
        )
    }

    /// Scales the quantity by a dimensionless value.
    public static func * (lhs: Force, rhs: Double) -> Force {
        Force(
            value: lhs.value(in: .newton) * rhs,
            unit: .newton
        )
    }

    /// Divides by a scalar, preserving Double behavior for zero divisors.
    public static func / (lhs: Force, rhs: Double) -> Force {
        Force(
            value: lhs.value(in: .newton) / rhs,
            unit: .newton
        )
    }
}
