//
//  SectionModulusTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Verifies cubic-unit conversions, scalar arithmetic, and section-modulus shorthand.
@Suite("Section Modulus Tests")
struct SectionModulusTests {
    /// Uses a relative tolerance so small SI values still receive meaningful checks.
    private func isClose(_ actual: Double, _ expected: Double) -> Bool {
        abs(actual - expected) <= max(abs(expected) * 1e-12, 1e-24)
    }

    /// Metric factors use cubed length conversions rather than linear factors.
    @Test
    func convertsMetricCubicUnits() {
        #expect(isClose(1.mm3.value(in: .cubicMeter), 1e-9))
        #expect(isClose(1.m3.value(in: .cubicMillimeter), 1e9))
        #expect(isClose(2_000_000.mm3.value(in: .cubicMeter), 0.002))
    }

    /// English factors use the international inch and foot cubed.
    @Test
    func convertsEnglishCubicUnits() {
        #expect(isClose(1.in3.value(in: .cubicMeter), 0.000016387064))
        #expect(isClose(1.ft3.value(in: .cubicMeter), 0.028316846592))
        #expect(isClose(1.in3.value(in: .cubicMillimeter), 16_387.064))
        #expect(isClose(1.ft3.value(in: .cubicInch), 1_728))
        #expect(isClose(0.000016387064.m3.value(in: .cubicInch), 1))
        #expect(isClose(0.028316846592.m3.value(in: .cubicFoot), 1))
    }

    /// Every unit preserves scalar values and round-trips through SI.
    @Test(arguments: [SectionModulusUnit.cubicMeter, .cubicMillimeter, .cubicInch, .cubicFoot])
    func roundTripsEachUnit(unit: SectionModulusUnit) {
        for value in [0.0, -2.5, 0.125, 1_000_000] {
            let quantity = SectionModulus(value: value, unit: unit)
            #expect(isClose(quantity.value(in: unit), value))
            let restored = SectionModulus(value: quantity.value(in: .cubicMeter), unit: .cubicMeter)
            #expect(isClose(restored.value(in: unit), value))
        }
    }

    /// Scalar arithmetic normalizes metric and English inputs to m³.
    @Test
    func arithmeticAcrossUnitSystems() {
        let lhs = 1.in3
        let rhs = 16_387.064.mm3
        #expect(isClose((lhs + rhs).value(in: .cubicInch), 2))
        #expect(abs((lhs - rhs).value(in: .cubicMeter)) < 1e-18)
        #expect(isClose((rhs - 2.in3).value(in: .cubicInch), -1))
    }

    /// Multiplication and division by scalars retain the section-modulus type.
    @Test
    func scalesSectionModuli() {
        let modulus = 2.in3
        #expect(isClose((modulus * 3).value(in: .cubicInch), 6))
        #expect(3 * modulus == modulus * 3)
        #expect(isClose((modulus / 2).value(in: .cubicInch), 1))
        #expect(isClose((modulus * -1).value(in: .cubicInch), -2))
    }

    /// Equality uses the stored SI value; ordering works across supported units.
    @Test
    func comparesSectionModuli() {
        #expect(2.m3 == SectionModulus(value: 2, unit: .cubicMeter))
        #expect(1.ft3 > 1.in3)
        #expect(1.mm3 < 1.in3)
        #expect(0.m3 < 1.mm3)
    }

    /// Integers, decimals, and numeric variables construct typed section moduli.
    @Test
    func supportsNumericShorthand() {
        #expect(isClose(2.m3.value(in: .cubicMeter), 2))
        #expect(isClose(2.mm3.value(in: .cubicMillimeter), 2))
        #expect(isClose(2.in3.value(in: .cubicInch), 2))
        #expect(isClose(2.ft3.value(in: .cubicFoot), 2))
        #expect(isClose(2.5.m3.value(in: .cubicMeter), 2.5))
        #expect(isClose(2.5.mm3.value(in: .cubicMillimeter), 2.5))
        #expect(isClose(2.5.in3.value(in: .cubicInch), 2.5))
        #expect(isClose(2.5.ft3.value(in: .cubicFoot), 2.5))
        let integer: Int8 = 2
        let decimal: Float = 0.5
        #expect(integer.in3 == 2.in3)
        #expect(decimal.mm3 == 0.5.mm3)
    }
}
