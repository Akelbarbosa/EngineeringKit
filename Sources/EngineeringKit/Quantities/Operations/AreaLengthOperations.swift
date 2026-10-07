//
//  AreaLengthOperations.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

extension Length {
    /// Multiplies two scalar lengths to produce area, normalizing their units.
    public static func * (lhs: Length, rhs: Length) -> Area {
        Area(value: lhs.value(in: .meter) * rhs.value(in: .meter), unit: .squareMeter)
    }
}

extension Area {
    /// Divides area by a scalar length to recover a length.
    ///
    /// This raw quantity operation preserves Double behavior for zero divisors.
    public static func / (lhs: Area, rhs: Length) -> Length {
        Length(value: lhs.value(in: .squareMeter) / rhs.value(in: .meter), unit: .meter)
    }
}
