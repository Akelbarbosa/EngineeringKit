//
//  Length+Literals.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Constructs length quantities from integer values.
public extension BinaryInteger {
    /// Interprets this value as meters (m).
    var meter: Length {
        Length(value: Double(self), unit: .meter)
    }

    /// Interprets this value as millimeters (mm).
    var millimeter: Length {
        Length(value: Double(self), unit: .millimeter)
    }
    /// Interprets this value as international inches (in).
    var inch: Length {
        Length(value: Double(self), unit: .inch)
    }

    /// Interprets this value as international feet (ft).
    var foot: Length {
        Length(value: Double(self), unit: .foot)
    }

    /// Interprets this value as international yards (yd).
    var yard: Length {
        Length(value: Double(self), unit: .yard)
    }
}

/// Constructs length quantities from floating-point values.
public extension BinaryFloatingPoint {
    /// Interprets this value as meters (m).
    var meter: Length {
        Length(value: Double(self), unit: .meter)
    }

    /// Interprets this value as millimeters (mm).
    var millimeter: Length {
        Length(value: Double(self), unit: .millimeter)
    }
    /// Interprets this value as international inches (in).
    var inch: Length {
        Length(value: Double(self), unit: .inch)
    }

    /// Interprets this value as international feet (ft).
    var foot: Length {
        Length(value: Double(self), unit: .foot)
    }

    /// Interprets this value as international yards (yd).
    var yard: Length {
        Length(value: Double(self), unit: .yard)
    }
}
