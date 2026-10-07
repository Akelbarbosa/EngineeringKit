//
//  TorqueUnit.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Supported units for expressing torque.
public enum TorqueUnit: Sendable {
    /// SI unit of torque (N·m).
    case newtonMeter
    /// One thousand newton-meters (kN·m).
    case kilonewtonMeter
    /// Pound-force inch (lbf·in).
    case poundForceInch
    /// Pound-force foot (lbf·ft).
    case poundForceFoot
    /// One thousand pound-force inches (kip·in).
    case kipInch
    /// One thousand pound-force feet (kip·ft).
    case kipFoot

    /// Multiplier from this unit to the canonical SI unit (NIST SP 811).
    internal var siConversionFactor: Double {
        switch self {
        case .newtonMeter:
            return 1
        case .kilonewtonMeter:
            return 1_000
        case .poundForceInch:
            return ForceUnit.poundForce.siConversionFactor * LengthUnit.inch.siConversionFactor
        case .poundForceFoot:
            return ForceUnit.poundForce.siConversionFactor * LengthUnit.foot.siConversionFactor
        case .kipInch:
            return ForceUnit.kip.siConversionFactor * LengthUnit.inch.siConversionFactor
        case .kipFoot:
            return ForceUnit.kip.siConversionFactor * LengthUnit.foot.siConversionFactor
        }
    }
}
