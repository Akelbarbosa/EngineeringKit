//
//  Area.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// A scalar area stored internally in square meters (m²).
///
/// Like the other raw quantity types, Area does not enforce physical ranges.
/// Geometry types validate the dimensions from which their areas are computed.
public struct Area: Sendable, Equatable, Comparable {
    /// The canonical SI value used by conversions and arithmetic.
    private let valueInSquareMeters: Double

    /// Creates a quantity by converting the supplied square unit to SI.
    public init(value: Double, unit: AreaUnit) {
        self.valueInSquareMeters = value * unit.siConversionFactor
    }

    /// Returns the quantity expressed in the requested square unit.
    public func value(in unit: AreaUnit) -> Double {
        valueInSquareMeters / unit.siConversionFactor
    }

    /// Orders quantities by their signed SI values.
    public static func < (lhs: Area, rhs: Area) -> Bool {
        lhs.valueInSquareMeters < rhs.valueInSquareMeters
    }

    /// Adds areas expressed in any supported units.
    public static func + (lhs: Area, rhs: Area) -> Area {
        Area(
            value: lhs.valueInSquareMeters + rhs.valueInSquareMeters,
            unit: .squareMeter
        )
    }

    /// Subtracts areas after normalizing their units.
    public static func - (lhs: Area, rhs: Area) -> Area {
        Area(
            value: lhs.valueInSquareMeters - rhs.valueInSquareMeters,
            unit: .squareMeter
        )
    }

    /// Scales the area by a dimensionless value.
    public static func * (lhs: Area, rhs: Double) -> Area {
        Area(value: lhs.valueInSquareMeters * rhs, unit: .squareMeter)
    }

    /// Scales the area with the scalar on the left.
    public static func * (lhs: Double, rhs: Area) -> Area {
        rhs * lhs
    }

    /// Divides by a scalar, preserving Double behavior for zero divisors.
    public static func / (lhs: Area, rhs: Double) -> Area {
        Area(value: lhs.valueInSquareMeters / rhs, unit: .squareMeter)
    }
}
