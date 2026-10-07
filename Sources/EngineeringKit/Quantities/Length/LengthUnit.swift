//
//  LengthUnit.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Supported units for expressing length.
public enum LengthUnit: Sendable {
    /// SI unit of length (m).
    case meter
    /// One thousandth of a meter (mm).
    case millimeter
    /// International inch (in), exactly 0.0254 meters.
    case inch
    /// International foot (ft), exactly 0.3048 meters.
    case foot
    /// International yard (yd), exactly 0.9144 meters.
    case yard

    /// Multiplier from this unit to the canonical SI unit (NIST SP 811).
    internal var siConversionFactor: Double {
        switch self {
        case .meter:
            return 1
        case .millimeter:
            return 0.001
        case .inch:
            return 0.0254
        case .foot:
            return 0.3048
        case .yard:
            return 0.9144
        }
    }
}
