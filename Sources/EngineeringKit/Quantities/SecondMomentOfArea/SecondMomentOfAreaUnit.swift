//
//  SecondMomentOfAreaUnit.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Supported units for the second moment of area (length⁴).
public enum SecondMomentOfAreaUnit: Sendable {
    /// Expresses the second moment in meters to the fourth power (m⁴).
    case meterToFourthPower
    /// Expresses the second moment in millimeters to the fourth power (mm⁴).
    case millimeterToFourthPower
    /// Expresses the second moment in international inches to the fourth power (in⁴).
    case inchToFourthPower
    /// Expresses the second moment in international feet to the fourth power (ft⁴).
    case footToFourthPower

    /// Multiplier to m⁴, derived from the corresponding length conversion.
    internal var siConversionFactor: Double {
        let meters: Double
        switch self {
        case .meterToFourthPower:
            meters = LengthUnit.meter.siConversionFactor
        case .millimeterToFourthPower:
            meters = LengthUnit.millimeter.siConversionFactor
        case .inchToFourthPower:
            meters = LengthUnit.inch.siConversionFactor
        case .footToFourthPower:
            meters = LengthUnit.foot.siConversionFactor
        }
        // Fourth-power units require the fourth power of the length multiplier.
        let square = meters * meters
        return square * square
    }
}
