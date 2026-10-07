//
//  SecondMomentOfArea+Literals.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Constructs second moments of area from integer values.
public extension BinaryInteger {
    /// Interprets this value as meters to the fourth power (m⁴).
    var m4: SecondMomentOfArea {
        SecondMomentOfArea(value: Double(self), unit: .meterToFourthPower)
    }

    /// Interprets this value as millimeters to the fourth power (mm⁴).
    var mm4: SecondMomentOfArea {
        SecondMomentOfArea(value: Double(self), unit: .millimeterToFourthPower)
    }

    /// Interprets this value as international inches to the fourth power (in⁴).
    var in4: SecondMomentOfArea {
        SecondMomentOfArea(value: Double(self), unit: .inchToFourthPower)
    }

    /// Interprets this value as international feet to the fourth power (ft⁴).
    var ft4: SecondMomentOfArea {
        SecondMomentOfArea(value: Double(self), unit: .footToFourthPower)
    }
}

/// Constructs second moments of area from floating-point values.
public extension BinaryFloatingPoint {
    /// Interprets this value as meters to the fourth power (m⁴).
    var m4: SecondMomentOfArea {
        SecondMomentOfArea(value: Double(self), unit: .meterToFourthPower)
    }

    /// Interprets this value as millimeters to the fourth power (mm⁴).
    var mm4: SecondMomentOfArea {
        SecondMomentOfArea(value: Double(self), unit: .millimeterToFourthPower)
    }

    /// Interprets this value as international inches to the fourth power (in⁴).
    var in4: SecondMomentOfArea {
        SecondMomentOfArea(value: Double(self), unit: .inchToFourthPower)
    }

    /// Interprets this value as international feet to the fourth power (ft⁴).
    var ft4: SecondMomentOfArea {
        SecondMomentOfArea(value: Double(self), unit: .footToFourthPower)
    }
}
