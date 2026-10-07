//
//  ForceUnit.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 5/10/26.
//

import Foundation

/// Supported units for expressing force.
public enum ForceUnit: Sendable {
    /// SI unit of force (N).
    case newton
    /// One thousand newtons (kN).
    case kilonewton
    /// Pound-force (lbf), defined using standard gravity.
    case poundForce
    /// One thousand pounds-force (kip).
    case kip

    /// Multiplier from this unit to the canonical SI unit (NIST SP 811).
    internal var siConversionFactor: Double {
        switch self {
        case .newton:
            return 1
        case .kilonewton:
            return 1_000
        case .poundForce:
            return 4.448_221_615_260_5
        case .kip:
            return 1_000 * ForceUnit.poundForce.siConversionFactor
        }
    }
}
