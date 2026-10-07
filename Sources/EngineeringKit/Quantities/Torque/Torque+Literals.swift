//
//  Torque+Literals.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Constructs torque quantities from integer values.
public extension BinaryInteger {
    /// Interprets this value as newton-meters (N·m).
    var newtonMeter: Torque {
        Torque(value: Double(self), unit: .newtonMeter)
    }

    /// Interprets this value as kilonewton-meters (kN·m).
    var knewtonMeter: Torque {
        Torque(value: Double(self), unit: .kilonewtonMeter)
    }
}

/// Constructs torque quantities from floating-point values.
public extension BinaryFloatingPoint {
    /// Interprets this value as newton-meters (N·m).
    var newtonMeter: Torque {
        Torque(value: Double(self), unit: .newtonMeter)
    }

    /// Interprets this value as kilonewton-meters (kN·m).
    var knewtonMeter: Torque {
        Torque(value: Double(self), unit: .kilonewtonMeter)
    }
}
