//
//  Torque.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// A signed scalar torque stored internally in newton-meters.
public struct Torque: Sendable, Equatable, Comparable {
    /// The canonical SI value used by conversions and arithmetic.
    private let valueInNewtonMeters: Double

    /// Creates a quantity by converting the supplied unit to SI.
    public init(value: Double, unit: TorqueUnit) {
        self.valueInNewtonMeters = value * unit.siConversionFactor
    }

    /// Returns the quantity expressed in the requested unit.
    public func value(in unit: TorqueUnit) -> Double {
        return valueInNewtonMeters / unit.siConversionFactor
    }

    /// Orders quantities by their signed SI values.
    public static func < (lhs: Torque, rhs: Torque) -> Bool {
        lhs.valueInNewtonMeters < rhs.valueInNewtonMeters
    }

    /// Adds quantities, allowing different input units.
    public static func + (lhs: Torque, rhs: Torque) -> Torque {
        Torque(value: lhs.valueInNewtonMeters + rhs.valueInNewtonMeters, unit: .newtonMeter)
    }

    /// Subtracts quantities, allowing different input units.
    public static func - (lhs: Torque, rhs: Torque) -> Torque {
        Torque(value: lhs.valueInNewtonMeters - rhs.valueInNewtonMeters, unit: .newtonMeter)
    }

    /// Scales the quantity by a dimensionless value.
    public static func * (lhs: Torque, rhs: Double) -> Torque {
        Torque(value: lhs.valueInNewtonMeters * rhs, unit: .newtonMeter)
    }

    /// Scales the quantity with the scalar on the left.
    public static func * (lhs: Double, rhs: Torque) -> Torque {
        rhs * lhs
    }

    /// Divides by a scalar, preserving Double behavior for zero divisors.
    public static func / (lhs: Torque, rhs: Double) -> Torque {
        Torque(value: lhs.valueInNewtonMeters / rhs, unit: .newtonMeter)
    }
}
