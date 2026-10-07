//
//  QuantityLiterals.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Constructs engineering quantities from integer values.
public extension BinaryInteger {
    /// Interprets this value as newtons (N).
    var newton: Force {
        Force(value: Double(self), unit: .newton)
    }

    /// Interprets this value as kilonewtons (kN).
    var knewton: Force {
        Force(value: Double(self), unit: .kilonewton)
    }

    /// Interprets this value as meters (m).
    var meter: Length {
        Length(value: Double(self), unit: .meter)
    }

    /// Interprets this value as millimeters (mm).
    var millimeter: Length {
        Length(value: Double(self), unit: .millimeter)
    }

    /// Interprets this value as newton-meters (N·m).
    var newtonMeter: Torque {
        Torque(value: Double(self), unit: .newtonMeter)
    }

    /// Interprets this value as kilonewton-meters (kN·m).
    var knewtonMeter: Torque {
        Torque(value: Double(self), unit: .kilonewtonMeter)
    }
}

/// Constructs engineering quantities from floating-point values.
public extension BinaryFloatingPoint {
    /// Interprets this value as newtons (N).
    var newton: Force {
        Force(value: Double(self), unit: .newton)
    }

    /// Interprets this value as kilonewtons (kN).
    var knewton: Force {
        Force(value: Double(self), unit: .kilonewton)
    }

    /// Interprets this value as meters (m).
    var meter: Length {
        Length(value: Double(self), unit: .meter)
    }

    /// Interprets this value as millimeters (mm).
    var millimeter: Length {
        Length(value: Double(self), unit: .millimeter)
    }

    /// Interprets this value as newton-meters (N·m).
    var newtonMeter: Torque {
        Torque(value: Double(self), unit: .newtonMeter)
    }

    /// Interprets this value as kilonewton-meters (kN·m).
    var knewtonMeter: Torque {
        Torque(value: Double(self), unit: .kilonewtonMeter)
    }
}
