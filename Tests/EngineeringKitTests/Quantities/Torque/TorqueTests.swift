//
//  TorqueTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Verifies conversions and operations for the quantities in this suite.
@Suite("Torque Tests")
struct TorqueTests {
    /// Checks conversion from and to the SI unit.
    @Test
    func convertsUnitsInBothDirections() {
        #expect(Torque(value: 2_000, unit: .newtonMeter).value(in: .kilonewtonMeter) == 2)
        #expect(Torque(value: 2, unit: .kilonewtonMeter).value(in: .newtonMeter) == 2_000)
    }

    /// Keeps the numeric value when requesting the original unit.
    @Test
    func preservesValueInSameUnit() {
        #expect(Torque(value: 250, unit: .newtonMeter).value(in: .newtonMeter) == 250)
        #expect(Torque(value: 250, unit: .kilonewtonMeter).value(in: .kilonewtonMeter) == 250)
    }

    /// Checks equality and ordering across equivalent units.
    @Test
    func comparesAcrossUnits() {
        let lhs = Torque(value: 2_000, unit: .newtonMeter)
        let rhs = Torque(value: 2, unit: .kilonewtonMeter)
        #expect(lhs == rhs)
        #expect(lhs > rhs / 2)
        #expect(lhs / 2 < rhs)
    }

    /// Checks arithmetic with mixed units and scalar operands.
    @Test
    func arithmeticAcrossUnits() {
        let lhs = Torque(value: 2_000, unit: .newtonMeter)
        let rhs = Torque(value: 2, unit: .kilonewtonMeter)
        #expect((lhs + rhs).value(in: .newtonMeter) == 2 * 2_000)
        #expect((lhs - rhs).value(in: .newtonMeter) == 0)
        #expect((lhs * 2).value(in: .newtonMeter) == 2 * 2_000)
        #expect(2 * lhs == lhs * 2)
        #expect((lhs / 2).value(in: .newtonMeter) == 2_000 / 2)
    }

    /// Preserves zero, negative, and fractional values through conversion.
    @Test(arguments: [0.0, -2.0, 0.125])
    func preservesSignedAndFractionalValues(value: Double) {
        let quantity = Torque(value: value, unit: .newtonMeter)
        let roundTrip = Torque(value: quantity.value(in: .kilonewtonMeter), unit: .kilonewtonMeter)
        #expect(abs(roundTrip.value(in: .newtonMeter) - value) < 1e-12)
    }
}
