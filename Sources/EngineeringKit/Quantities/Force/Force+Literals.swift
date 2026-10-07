//
//  Force+Literals.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Constructs force quantities from integer values.
public extension BinaryInteger {
    /// Interprets this value as newtons (N).
    var newton: Force {
        Force(value: Double(self), unit: .newton)
    }

    /// Interprets this value as kilonewtons (kN).
    var knewton: Force {
        Force(value: Double(self), unit: .kilonewton)
    }
    /// Interprets this value as pounds-force (lbf).
    var lbf: Force {
        Force(value: Double(self), unit: .poundForce)
    }

    /// Interprets this value as kips (1000 lbf).
    var kip: Force {
        Force(value: Double(self), unit: .kip)
    }
}

/// Constructs force quantities from floating-point values.
public extension BinaryFloatingPoint {
    /// Interprets this value as newtons (N).
    var newton: Force {
        Force(value: Double(self), unit: .newton)
    }

    /// Interprets this value as kilonewtons (kN).
    var knewton: Force {
        Force(value: Double(self), unit: .kilonewton)
    }
    /// Interprets this value as pounds-force (lbf).
    var lbf: Force {
        Force(value: Double(self), unit: .poundForce)
    }

    /// Interprets this value as kips (1000 lbf).
    var kip: Force {
        Force(value: Double(self), unit: .kip)
    }
}
