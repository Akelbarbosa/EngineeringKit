//
//  SectionModulusOperationsTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Verifies S = I / c and its inverse using metric, English, and mixed inputs.
@Suite("Section Modulus Operation Tests")
struct SectionModulusOperationsTests {
    /// Applies a relative tolerance to conversion results.
    private func isClose(_ actual: Double, _ expected: Double) -> Bool {
        abs(actual - expected) <= max(abs(expected) * 1e-12, 1e-24)
    }

    /// Dividing mm⁴ by mm gives the expected elastic section modulus in mm³.
    @Test
    func computesMetricSectionModulus() {
        let modulus: SectionModulus = 2_000_000.mm4 / 50.millimeter
        #expect(isClose(modulus.value(in: .cubicMillimeter), 40_000))
        #expect(isClose(modulus.value(in: .cubicMeter), 0.00004))
    }

    /// Dividing in⁴ by in gives the expected elastic section modulus in in³.
    @Test
    func computesEnglishSectionModulus() {
        let modulus: SectionModulus = 10.in4 / 2.inch
        #expect(isClose(modulus.value(in: .cubicInch), 5))
        #expect(isClose((2.ft4 / 1.foot).value(in: .cubicFoot), 2))
    }

    /// Different unit systems can be combined in the typed quotient.
    @Test
    func computesMixedSystemSectionModulus() {
        #expect(isClose((10.in4 / 50.8.millimeter).value(in: .cubicInch), 5))
        #expect(isClose((4.162314256e-6.m4 / 2.inch).value(in: .cubicInch), 5))
    }

    /// Multiplication in either operand order recovers the original second moment.
    @Test
    func recoversSecondMomentOfArea() {
        let modulus: SectionModulus = 5.in3
        let moment: SecondMomentOfArea = modulus * 50.8.millimeter
        #expect(isClose(moment.value(in: .inchToFourthPower), 10))
        #expect(50.8.millimeter * modulus == moment)
        let distance = 50.millimeter
        let original = 2_000_000.mm4
        #expect(isClose(((original / distance) * distance).value(in: .millimeterToFourthPower), 2_000_000))
    }

    /// Raw scalar operators preserve zero, signed, infinity, and NaN behavior.
    @Test
    func preservesScalarEdgeCases() {
        #expect((0.m4 / 1.meter).value(in: .cubicMeter) == 0)
        #expect((1.m4 / (-2).meter).value(in: .cubicMeter) == -0.5)
        #expect((1.m4 / 0.meter).value(in: .cubicMeter) == Double.infinity)
        #expect((0.m4 / 0.meter).value(in: .cubicMeter).isNaN)
        #expect((0.m3 * 1.meter).value(in: .meterToFourthPower) == 0)
    }
}
