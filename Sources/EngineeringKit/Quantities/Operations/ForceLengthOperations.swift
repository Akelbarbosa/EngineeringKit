//
//  ForceLengthOperations.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

extension Force {
    /// Computes torque using a signed perpendicular lever arm.
    public static func * (lhs: Force, rhs: Length) -> Torque {
        Torque(value: lhs.value(in: .newton) * rhs.value(in: .meter), unit: .newtonMeter)
    }
}

extension Length {
    /// Computes torque using a signed perpendicular lever arm.
    public static func * (lhs: Length, rhs: Force) -> Torque {
        rhs * lhs
    }
}
