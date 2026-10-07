//
//  AreaUnit.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Supported units for area (length²).
public enum AreaUnit: Sendable {
    /// Expresses area in square meters (m²).
    case squareMeter
    /// Expresses area in square millimeters (mm²).
    case squareMillimeter
    /// Expresses area in international square inches (in²).
    case squareInch
    /// Expresses area in international square feet (ft²).
    case squareFoot

    /// Multiplier to m², derived from the corresponding length conversion.
    internal var siConversionFactor: Double {
        let meters: Double
        switch self {
        case .squareMeter:
            meters = LengthUnit.meter.siConversionFactor
        case .squareMillimeter:
            meters = LengthUnit.millimeter.siConversionFactor
        case .squareInch:
            meters = LengthUnit.inch.siConversionFactor
        case .squareFoot:
            meters = LengthUnit.foot.siConversionFactor
        }
        return meters * meters
    }
}
