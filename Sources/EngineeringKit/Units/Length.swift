//
//  Length.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Foundation

/// A signed scalar length stored internally in meters.
public struct Length: Sendable, Equatable, Comparable {
    /// The canonical SI value used by conversions and arithmetic.
    private let valueInMeters: Double

    /// Creates a quantity by converting the supplied unit to SI.
    public init(value: Double, unit: LengthUnit) {
        switch unit {
        case .meter:
            self.valueInMeters = value
        case .millimeter:
            self.valueInMeters = value * 0.001
        }
    }

    /// Returns the quantity expressed in the requested unit.
    public func value(in unit: LengthUnit) -> Double {
        switch unit {
        case .meter:
            return valueInMeters
        case .millimeter:
            return valueInMeters / 0.001
        }
    }

    /// Orders quantities by their signed SI values.
    public static func < (lhs: Length, rhs: Length) -> Bool {
        lhs.valueInMeters < rhs.valueInMeters
    }

    /// Adds quantities, allowing different input units.
    public static func + (lhs: Length, rhs: Length) -> Length {
        Length(value: lhs.valueInMeters + rhs.valueInMeters, unit: .meter)
    }

    /// Subtracts quantities, allowing different input units.
    public static func - (lhs: Length, rhs: Length) -> Length {
        Length(value: lhs.valueInMeters - rhs.valueInMeters, unit: .meter)
    }

    /// Scales the quantity by a dimensionless value.
    public static func * (lhs: Length, rhs: Double) -> Length {
        Length(value: lhs.valueInMeters * rhs, unit: .meter)
    }

    /// Scales the quantity with the scalar on the left.
    public static func * (lhs: Double, rhs: Length) -> Length {
        rhs * lhs
    }

    /// Divides by a scalar, preserving Double behavior for zero divisors.
    public static func / (lhs: Length, rhs: Double) -> Length {
        Length(value: lhs.valueInMeters / rhs, unit: .meter)
    }
}
