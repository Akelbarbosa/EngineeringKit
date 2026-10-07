//
//  Density.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Foundation

/// Mass per unit volume, stored internally in kilograms per cubic meter.
///
/// Like the other scalar quantities, this type does not validate physical ranges.
public struct Density: Sendable, Equatable, Comparable {
    /// The canonical SI value used by conversions and arithmetic.
    private let valueInKilogramsPerCubicMeter: Double

    /// Creates a quantity by converting the supplied unit to SI.
    public init(value: Double, unit: DensityUnit) {
        switch unit {
        case .kilogramPerCubicMeter:
            self.valueInKilogramsPerCubicMeter = value
        case .gramPerCubicCentimeter:
            self.valueInKilogramsPerCubicMeter = value * 1_000
        }
    }

    /// Returns the quantity expressed in the requested unit.
    public func value(in unit: DensityUnit) -> Double {
        switch unit {
        case .kilogramPerCubicMeter:
            return valueInKilogramsPerCubicMeter
        case .gramPerCubicCentimeter:
            return valueInKilogramsPerCubicMeter / 1_000
        }
    }

    /// Orders quantities by their signed SI values.
    public static func < (lhs: Density, rhs: Density) -> Bool {
        lhs.valueInKilogramsPerCubicMeter < rhs.valueInKilogramsPerCubicMeter
    }

    /// Adds quantities, allowing different input units.
    public static func + (lhs: Density, rhs: Density) -> Density {
        Density(value: lhs.valueInKilogramsPerCubicMeter + rhs.valueInKilogramsPerCubicMeter, unit: .kilogramPerCubicMeter)
    }

    /// Subtracts quantities, allowing different input units.
    public static func - (lhs: Density, rhs: Density) -> Density {
        Density(value: lhs.valueInKilogramsPerCubicMeter - rhs.valueInKilogramsPerCubicMeter, unit: .kilogramPerCubicMeter)
    }

    /// Scales the quantity by a dimensionless value.
    public static func * (lhs: Density, rhs: Double) -> Density {
        Density(value: lhs.valueInKilogramsPerCubicMeter * rhs, unit: .kilogramPerCubicMeter)
    }

    /// Scales the quantity with the scalar on the left.
    public static func * (lhs: Double, rhs: Density) -> Density {
        rhs * lhs
    }

    /// Divides by a scalar, preserving Double behavior for zero divisors.
    public static func / (lhs: Density, rhs: Double) -> Density {
        Density(value: lhs.valueInKilogramsPerCubicMeter / rhs, unit: .kilogramPerCubicMeter)
    }
}
