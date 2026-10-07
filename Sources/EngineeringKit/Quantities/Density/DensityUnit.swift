//
//  DensityUnit.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Supported units for expressing mass density.
public enum DensityUnit: Sendable {
    /// SI unit of mass density (kg/m³).
    case kilogramPerCubicMeter
    /// One thousand kilograms per cubic meter (g/cm³).
    case gramPerCubicCentimeter
    /// Avoirdupois pound-mass per cubic foot (lbm/ft³), not weight density.
    case poundMassPerCubicFoot
    /// Avoirdupois pound-mass per cubic inch (lbm/in³), not weight density.
    case poundMassPerCubicInch

    /// Multiplier from this unit to the canonical SI unit (NIST SP 811).
    internal var siConversionFactor: Double {
        switch self {
        case .kilogramPerCubicMeter:
            return 1
        case .gramPerCubicCentimeter:
            return 1_000
        case .poundMassPerCubicFoot:
            let meters = LengthUnit.foot.siConversionFactor
            // The avoirdupois pound is exactly 0.45359237 kilograms.
            return 0.453_592_37 / (meters * meters * meters)
        case .poundMassPerCubicInch:
            let meters = LengthUnit.inch.siConversionFactor
            // The avoirdupois pound is exactly 0.45359237 kilograms.
            return 0.453_592_37 / (meters * meters * meters)
        }
    }
}
