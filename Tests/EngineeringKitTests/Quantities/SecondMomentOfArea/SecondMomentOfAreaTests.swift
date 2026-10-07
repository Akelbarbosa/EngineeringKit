//
//  SecondMomentOfAreaTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Verifies fourth-power conversions, scalar arithmetic, and numeric shorthand.
@Suite("Second Moment of Area Tests")
struct SecondMomentOfAreaTests {
    /// Uses relative tolerance so tiny SI values still receive meaningful checks.
    private func isClose(_ actual: Double, _ expected: Double) -> Bool {
        abs(actual - expected) <= max(abs(expected) * 1e-12, 1e-24)
    }

    /// Millimeter conversion uses 10⁻¹² rather than the linear length multiplier.
    @Test
    func convertsMetricFourthPowerUnits() {
        #expect(isClose(1.mm4.value(in: .meterToFourthPower), 1e-12))
        #expect(isClose(1.m4.value(in: .millimeterToFourthPower), 1e12))
        #expect(isClose(2_000_000.mm4.value(in: .meterToFourthPower), 2e-6))
    }

    /// English conversion factors are the fourth powers of inch and foot lengths.
    @Test
    func convertsEnglishFourthPowerUnits() {
        #expect(isClose(1.in4.value(in: .meterToFourthPower), 4.162314256e-7))
        #expect(isClose(1.ft4.value(in: .meterToFourthPower), 0.0086309748412416))
        #expect(isClose(1.in4.value(in: .millimeterToFourthPower), 416_231.4256))
        #expect(isClose(1.ft4.value(in: .inchToFourthPower), 20_736))
        #expect(isClose(4.162314256e-7.m4.value(in: .inchToFourthPower), 1))
        #expect(isClose(0.0086309748412416.m4.value(in: .footToFourthPower), 1))
    }

    /// Every unit preserves its original value and round-trips through SI.
    @Test(arguments: [SecondMomentOfAreaUnit.meterToFourthPower, .millimeterToFourthPower,
                      .inchToFourthPower, .footToFourthPower])
    func roundTripsEachUnit(unit: SecondMomentOfAreaUnit) {
        for value in [0.0, -2.5, 0.125, 1_000_000] {
            let original = SecondMomentOfArea(value: value, unit: unit)
            #expect(isClose(original.value(in: unit), value))
            let restored = SecondMomentOfArea(
                value: original.value(in: .meterToFourthPower), unit: .meterToFourthPower
            )
            #expect(isClose(restored.value(in: unit), value))
        }
    }

    /// Addition and subtraction normalize metric and English inputs to m⁴.
    @Test
    func arithmeticAcrossUnitSystems() {
        let lhs = 1.in4
        let rhs = 416_231.4256.mm4
        #expect(isClose((lhs + rhs).value(in: .inchToFourthPower), 2))
        #expect(abs((lhs - rhs).value(in: .meterToFourthPower)) < 1e-20)
        #expect(isClose((rhs - 2.in4).value(in: .inchToFourthPower), -1))
    }

    /// Scalar operations preserve the dimension and support either operand order.
    @Test
    func scalesSecondMoments() {
        let moment = 2.in4
        #expect(isClose((moment * 3).value(in: .inchToFourthPower), 6))
        #expect(3 * moment == moment * 3)
        #expect(isClose((moment / 2).value(in: .inchToFourthPower), 1))
        #expect(isClose((moment * -1).value(in: .inchToFourthPower), -2))
    }

    /// Equality compares stored SI values, and ordering works across units.
    @Test
    func comparesSecondMoments() {
        #expect(2.m4 == SecondMomentOfArea(value: 2, unit: .meterToFourthPower))
        #expect(1.ft4 > 1.in4)
        #expect(1.mm4 < 1.in4)
        #expect(0.m4 < 1.mm4)
    }

    /// Integer and decimal shorthand creates the same public quantity type.
    @Test
    func supportsNumericShorthand() {
        #expect(isClose(2.m4.value(in: .meterToFourthPower), 2))
        #expect(isClose(2.mm4.value(in: .millimeterToFourthPower), 2))
        #expect(isClose(2.in4.value(in: .inchToFourthPower), 2))
        #expect(isClose(2.ft4.value(in: .footToFourthPower), 2))
        #expect(isClose(2.5.m4.value(in: .meterToFourthPower), 2.5))
        #expect(isClose(2.5.mm4.value(in: .millimeterToFourthPower), 2.5))
        #expect(isClose(2.5.in4.value(in: .inchToFourthPower), 2.5))
        #expect(isClose(2.5.ft4.value(in: .footToFourthPower), 2.5))
        let integer: Int8 = 2
        let decimal: Float = 0.5
        #expect(integer.in4 == 2.in4)
        #expect(decimal.mm4 == 0.5.mm4)
    }
}
