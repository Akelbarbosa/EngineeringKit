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
    /// Interprets this value as pound-force inches (lbf·in).
    var lbfInch: Torque {
        Torque(value: Double(self), unit: .poundForceInch)
    }

    /// Interprets this value as pound-force feet (lbf·ft).
    var lbfFoot: Torque {
        Torque(value: Double(self), unit: .poundForceFoot)
    }

    /// Interprets this value as kip-inches (kip·in).
    var kipInch: Torque {
        Torque(value: Double(self), unit: .kipInch)
    }

    /// Interprets this value as kip-feet (kip·ft).
    var kipFoot: Torque {
        Torque(value: Double(self), unit: .kipFoot)
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
    /// Interprets this value as pound-force inches (lbf·in).
    var lbfInch: Torque {
        Torque(value: Double(self), unit: .poundForceInch)
    }

    /// Interprets this value as pound-force feet (lbf·ft).
    var lbfFoot: Torque {
        Torque(value: Double(self), unit: .poundForceFoot)
    }

    /// Interprets this value as kip-inches (kip·in).
    var kipInch: Torque {
        Torque(value: Double(self), unit: .kipInch)
    }

    /// Interprets this value as kip-feet (kip·ft).
    var kipFoot: Torque {
        Torque(value: Double(self), unit: .kipFoot)
    }
}
