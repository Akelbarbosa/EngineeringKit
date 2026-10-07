//
//  Length+Literals.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Constructs length quantities from integer values.
public extension BinaryInteger {
    /// Interprets this value as meters (m).
    var meter: Length {
        Length(value: Double(self), unit: .meter)
    }

    /// Interprets this value as millimeters (mm).
    var millimeter: Length {
        Length(value: Double(self), unit: .millimeter)
    }
}

/// Constructs length quantities from floating-point values.
public extension BinaryFloatingPoint {
    /// Interprets this value as meters (m).
    var meter: Length {
        Length(value: Double(self), unit: .meter)
    }

    /// Interprets this value as millimeters (mm).
    var millimeter: Length {
        Length(value: Double(self), unit: .millimeter)
    }
}
