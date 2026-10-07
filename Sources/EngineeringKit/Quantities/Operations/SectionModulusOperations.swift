//
//  SectionModulusOperations.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

extension SecondMomentOfArea {
    /// Divides a second moment of area by a length to produce section modulus.
    ///
    /// For the elastic section modulus S = I / c, the length must be the positive
    /// extreme-fiber distance from the same neutral axis as I. This operator
    /// performs scalar arithmetic without validating geometry; zero divisors
    /// preserve Double infinity and NaN behavior.
    public static func / (lhs: SecondMomentOfArea, rhs: Length) -> SectionModulus {
        SectionModulus(
            value: lhs.value(in: .meterToFourthPower) / rhs.value(in: .meter),
            unit: .cubicMeter
        )
    }
}

extension SectionModulus {
    /// Recovers I = S × c for the same neutral axis and extreme fiber.
    public static func * (lhs: SectionModulus, rhs: Length) -> SecondMomentOfArea {
        SecondMomentOfArea(
            value: lhs.value(in: .cubicMeter) * rhs.value(in: .meter),
            unit: .meterToFourthPower
        )
    }
}

extension Length {
    /// Recovers I = c × S with the distance on the left.
    public static func * (lhs: Length, rhs: SectionModulus) -> SecondMomentOfArea {
        rhs * lhs
    }
}
