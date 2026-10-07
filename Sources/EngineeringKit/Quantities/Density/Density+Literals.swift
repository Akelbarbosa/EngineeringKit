//
//  Density+Literals.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Constructs density quantities from integer values.
public extension BinaryInteger {
    /// Interprets this value as kilograms per cubic meter (kg/m³).
    var kgPerCubicMeter: Density {
        Density(value: Double(self), unit: .kilogramPerCubicMeter)
    }

    /// Interprets this value as grams per cubic centimeter (g/cm³).
    var gPerCubicCentimeter: Density {
        Density(value: Double(self), unit: .gramPerCubicCentimeter)
    }
    /// Interprets this value as pounds-mass per cubic foot (lbm/ft³).
    var lbmPerCubicFoot: Density {
        Density(value: Double(self), unit: .poundMassPerCubicFoot)
    }

    /// Interprets this value as pounds-mass per cubic inch (lbm/in³).
    var lbmPerCubicInch: Density {
        Density(value: Double(self), unit: .poundMassPerCubicInch)
    }
}

/// Constructs density quantities from floating-point values.
public extension BinaryFloatingPoint {
    /// Interprets this value as kilograms per cubic meter (kg/m³).
    var kgPerCubicMeter: Density {
        Density(value: Double(self), unit: .kilogramPerCubicMeter)
    }

    /// Interprets this value as grams per cubic centimeter (g/cm³).
    var gPerCubicCentimeter: Density {
        Density(value: Double(self), unit: .gramPerCubicCentimeter)
    }
    /// Interprets this value as pounds-mass per cubic foot (lbm/ft³).
    var lbmPerCubicFoot: Density {
        Density(value: Double(self), unit: .poundMassPerCubicFoot)
    }

    /// Interprets this value as pounds-mass per cubic inch (lbm/in³).
    var lbmPerCubicInch: Density {
        Density(value: Double(self), unit: .poundMassPerCubicInch)
    }
}
