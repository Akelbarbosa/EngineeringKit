//
//  LengthTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Verifies conversions and operations for the quantities in this suite.
@Suite("Length Tests")
struct LengthTests {
    /// Checks conversion from and to the SI unit.
    @Test
    func convertsUnitsInBothDirections() {
        #expect(Length(value: 2, unit: .meter).value(in: .millimeter) == 2_000)
        #expect(Length(value: 2_000, unit: .millimeter).value(in: .meter) == 2)
    }

    /// Keeps the numeric value when requesting the original unit.
    @Test
    func preservesValueInSameUnit() {
        #expect(Length(value: 250, unit: .meter).value(in: .meter) == 250)
        #expect(Length(value: 250, unit: .millimeter).value(in: .millimeter) == 250)
    }

    /// Checks equality and ordering across equivalent units.
    @Test
    func comparesAcrossUnits() {
        let lhs = Length(value: 2, unit: .meter)
        let rhs = Length(value: 2_000, unit: .millimeter)
        #expect(lhs == rhs)
        #expect(lhs > rhs / 2)
        #expect(lhs / 2 < rhs)
    }

    /// Checks arithmetic with mixed units and scalar operands.
    @Test
    func arithmeticAcrossUnits() {
        let lhs = Length(value: 2, unit: .meter)
        let rhs = Length(value: 2_000, unit: .millimeter)
        #expect((lhs + rhs).value(in: .meter) == 2 * 2)
        #expect((lhs - rhs).value(in: .meter) == 0)
        #expect((lhs * 2).value(in: .meter) == 2 * 2)
        #expect(2 * lhs == lhs * 2)
        #expect((lhs / 2).value(in: .meter) == 2 / 2)
    }

    /// Preserves zero, negative, and fractional values through conversion.
    @Test(arguments: [0.0, -2.0, 0.125])
    func preservesSignedAndFractionalValues(value: Double) {
        let quantity = Length(value: value, unit: .meter)
        let roundTrip = Length(value: quantity.value(in: .millimeter), unit: .millimeter)
        #expect(abs(roundTrip.value(in: .meter) - value) < 1e-12)
    }
}
