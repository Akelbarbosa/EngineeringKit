//
//  DensityTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Verifies density conversions, arithmetic, and the public numeric shorthand.
@Suite("Density Tests")
struct DensityTests {
    /// The volume conversion makes one g/cm³ equal to one thousand kg/m³.
    @Test
    func convertsUnitsInBothDirections() {
        let si = Density(value: 2_500, unit: .kilogramPerCubicMeter)
        let grams = Density(value: 2.5, unit: .gramPerCubicCentimeter)
        #expect(si.value(in: .gramPerCubicCentimeter) == 2.5)
        #expect(grams.value(in: .kilogramPerCubicMeter) == 2_500)
        #expect(si == grams)
    }

    /// Requesting the original unit preserves its numeric value.
    @Test
    func preservesValueInSameUnit() {
        #expect(125.kgPerCubicMeter.value(in: .kilogramPerCubicMeter) == 125)
        #expect(0.125.gPerCubicCentimeter.value(in: .gramPerCubicCentimeter) == 0.125)
    }

    /// Mixed-unit arithmetic uses the canonical SI representation.
    @Test
    func arithmeticAndComparisonAcrossUnits() {
        let lhs = 1_500.kgPerCubicMeter
        let rhs = 0.5.gPerCubicCentimeter
        #expect(lhs > rhs)
        #expect(rhs < lhs)
        #expect((lhs + rhs) == 2.gPerCubicCentimeter)
        #expect((rhs - lhs) == (-1_000).kgPerCubicMeter)
        #expect(lhs * 2 == 3.gPerCubicCentimeter)
        #expect(2 * lhs == lhs * 2)
        #expect(lhs / 2 == 750.kgPerCubicMeter)
    }

    /// Both shorthand units support integers, decimals, and numeric variables.
    @Test
    func constructsFromNumericValues() {
        #expect(1.gPerCubicCentimeter == 1_000.kgPerCubicMeter)
        #expect(1.5.gPerCubicCentimeter == 1_500.kgPerCubicMeter)
        #expect(1.5.kgPerCubicMeter.value(in: .kilogramPerCubicMeter) == 1.5)
        let integer: Int8 = 2
        let decimal: Float = 0.5
        #expect(integer.gPerCubicCentimeter == 2_000.kgPerCubicMeter)
        #expect(decimal.kgPerCubicMeter == 0.5.kgPerCubicMeter)
    }

    /// Conversion preserves scalar signs, zero, and fractional values.
    @Test(arguments: [0.0, -125.0, 0.125])
    func roundTripsScalarValues(value: Double) {
        let original = value.kgPerCubicMeter
        let restored = original.value(in: .gramPerCubicCentimeter).gPerCubicCentimeter
        #expect(abs(restored.value(in: .kilogramPerCubicMeter) - value) < 1e-12)
    }
}
