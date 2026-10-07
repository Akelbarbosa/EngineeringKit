//
//  SectionModulus+Literals.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Constructs section moduli from integer values.
public extension BinaryInteger {
    /// Interprets this value as cubic meters (m³) of section modulus.
    var m3: SectionModulus {
        SectionModulus(value: Double(self), unit: .cubicMeter)
    }

    /// Interprets this value as cubic millimeters (mm³) of section modulus.
    var mm3: SectionModulus {
        SectionModulus(value: Double(self), unit: .cubicMillimeter)
    }

    /// Interprets this value as international cubic inches (in³) of section modulus.
    var in3: SectionModulus {
        SectionModulus(value: Double(self), unit: .cubicInch)
    }

    /// Interprets this value as international cubic feet (ft³) of section modulus.
    var ft3: SectionModulus {
        SectionModulus(value: Double(self), unit: .cubicFoot)
    }
}

/// Constructs section moduli from floating-point values.
public extension BinaryFloatingPoint {
    /// Interprets this value as cubic meters (m³) of section modulus.
    var m3: SectionModulus {
        SectionModulus(value: Double(self), unit: .cubicMeter)
    }

    /// Interprets this value as cubic millimeters (mm³) of section modulus.
    var mm3: SectionModulus {
        SectionModulus(value: Double(self), unit: .cubicMillimeter)
    }

    /// Interprets this value as international cubic inches (in³) of section modulus.
    var in3: SectionModulus {
        SectionModulus(value: Double(self), unit: .cubicInch)
    }

    /// Interprets this value as international cubic feet (ft³) of section modulus.
    var ft3: SectionModulus {
        SectionModulus(value: Double(self), unit: .cubicFoot)
    }
}
