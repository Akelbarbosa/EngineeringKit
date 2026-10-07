//
//  SectionModulusUnit.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Supported units for elastic section modulus (length³).
public enum SectionModulusUnit: Sendable {
    /// Expresses the section modulus in cubic meters (m³).
    case cubicMeter
    /// Expresses the section modulus in cubic millimeters (mm³).
    case cubicMillimeter
    /// Expresses the section modulus in international cubic inches (in³).
    case cubicInch
    /// Expresses the section modulus in international cubic feet (ft³).
    case cubicFoot

    /// Multiplier to m³, derived from the corresponding length conversion.
    internal var siConversionFactor: Double {
        let meters: Double
        switch self {
        case .cubicMeter:
            meters = LengthUnit.meter.siConversionFactor
        case .cubicMillimeter:
            meters = LengthUnit.millimeter.siConversionFactor
        case .cubicInch:
            meters = LengthUnit.inch.siConversionFactor
        case .cubicFoot:
            meters = LengthUnit.foot.siConversionFactor
        }
        // Cubic units require the cube of the length multiplier.
        return meters * meters * meters
    }
}
