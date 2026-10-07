//
//  Area+Literals.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Constructs areas from integer values.
public extension BinaryInteger {
    /// Interprets this value as square meters (m²).
    var m2: Area {
        Area(value: Double(self), unit: .squareMeter)
    }

    /// Interprets this value as square millimeters (mm²).
    var mm2: Area {
        Area(value: Double(self), unit: .squareMillimeter)
    }

    /// Interprets this value as international square inches (in²).
    var in2: Area {
        Area(value: Double(self), unit: .squareInch)
    }

    /// Interprets this value as international square feet (ft²).
    var ft2: Area {
        Area(value: Double(self), unit: .squareFoot)
    }
}

/// Constructs areas from floating-point values.
public extension BinaryFloatingPoint {
    /// Interprets this value as square meters (m²).
    var m2: Area {
        Area(value: Double(self), unit: .squareMeter)
    }

    /// Interprets this value as square millimeters (mm²).
    var mm2: Area {
        Area(value: Double(self), unit: .squareMillimeter)
    }

    /// Interprets this value as international square inches (in²).
    var in2: Area {
        Area(value: Double(self), unit: .squareInch)
    }

    /// Interprets this value as international square feet (ft²).
    var ft2: Area {
        Area(value: Double(self), unit: .squareFoot)
    }
}
