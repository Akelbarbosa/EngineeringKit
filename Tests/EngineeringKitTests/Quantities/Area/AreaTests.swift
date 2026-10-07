//
//  AreaTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Checks area conversion and arithmetic with independent square-unit references.
@Suite("Area Tests")
struct AreaTests {
    /// Applies relative tolerance to small SI values as well as ordinary values.
    private func isClose(_ actual: Double, _ expected: Double) -> Bool {
        abs(actual - expected) <= max(abs(expected) * 1e-12, 1e-24)
    }

    /// Metric area factors use the square of their length factors.
    @Test
    func convertsMetricAreaUnits() {
        #expect(isClose(1.mm2.value(in: .squareMeter), 1e-6))
        #expect(isClose(1.m2.value(in: .squareMillimeter), 1e6))
    }

    /// English areas follow the international inch and foot definitions squared.
    @Test
    func convertsEnglishAreaUnits() {
        #expect(isClose(1.in2.value(in: .squareMeter), 0.00064516))
        #expect(isClose(1.ft2.value(in: .squareMeter), 0.09290304))
        #expect(isClose(1.in2.value(in: .squareMillimeter), 645.16))
        #expect(isClose(1.ft2.value(in: .squareInch), 144))
        #expect(isClose(0.00064516.m2.value(in: .squareInch), 1))
        #expect(isClose(0.09290304.m2.value(in: .squareFoot), 1))
    }

    /// Every supported area unit preserves scalar values through SI conversion.
    @Test(arguments: [AreaUnit.squareMeter, .squareMillimeter, .squareInch, .squareFoot])
    func roundTripsEachUnit(unit: AreaUnit) {
        for value in [0.0, -2.5, 0.125, 1_000_000] {
            let area = Area(value: value, unit: unit)
            #expect(isClose(area.value(in: unit), value))
            let restored = Area(value: area.value(in: .squareMeter), unit: .squareMeter)
            #expect(isClose(restored.value(in: unit), value))
        }
    }

    /// Area arithmetic normalizes metric and English inputs to SI.
    @Test
    func arithmeticAcrossUnitSystems() {
        #expect(isClose((1.in2 + 645.16.mm2).value(in: .squareInch), 2))
        #expect(abs((1.in2 - 645.16.mm2).value(in: .squareMeter)) < 1e-18)
        #expect(isClose((1.in2 - 2.in2).value(in: .squareInch), -1))
    }

    /// Scalar arithmetic keeps the area dimension in both operand orders.
    @Test
    func scalesAreas() {
        #expect(isClose((2.in2 * 3).value(in: .squareInch), 6))
        #expect(3 * 2.in2 == 2.in2 * 3)
        #expect(isClose((2.in2 / 2).value(in: .squareInch), 1))
    }

    /// Equality uses SI storage and ordering works across area units.
    @Test
    func comparesAreas() {
        #expect(2.m2 == Area(value: 2, unit: .squareMeter))
        #expect(1.ft2 > 1.in2)
        #expect(1.mm2 < 1.in2)
    }

    /// Each numeric abbreviation supports integers, decimals, and variables.
    @Test
    func supportsNumericShorthand() {
        #expect(isClose(2.m2.value(in: .squareMeter), 2))
        #expect(isClose(2.mm2.value(in: .squareMillimeter), 2))
        #expect(isClose(2.in2.value(in: .squareInch), 2))
        #expect(isClose(2.ft2.value(in: .squareFoot), 2))
        #expect(isClose(2.5.m2.value(in: .squareMeter), 2.5))
        #expect(isClose(2.5.mm2.value(in: .squareMillimeter), 2.5))
        #expect(isClose(2.5.in2.value(in: .squareInch), 2.5))
        #expect(isClose(2.5.ft2.value(in: .squareFoot), 2.5))
        let integer: Int8 = 2
        let decimal: Float = 0.5
        #expect(integer.in2 == 2.in2)
        #expect(decimal.mm2 == 0.5.mm2)
    }
}
