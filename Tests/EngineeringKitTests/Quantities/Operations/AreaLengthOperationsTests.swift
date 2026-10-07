//
//  AreaLengthOperationsTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Checks the dimensional relationship between area and scalar lengths.
@Suite("Area × Length Operation Tests")
struct AreaLengthOperationsTests {
    /// Length products produce area even when the inputs use different systems.
    @Test
    func multipliesLengths() {
        let area: Area = 2.inch * 50.8.millimeter
        #expect(abs(area.value(in: .squareInch) - 4) < 1e-12)
        #expect(50.8.millimeter * 2.inch == area)
    }

    /// Dividing area by a side length recovers the other side in mixed units.
    @Test
    func recoversLength() {
        let length: Length = 4.in2 / 50.8.millimeter
        #expect(abs(length.value(in: .inch) - 2) < 1e-12)
        #expect(abs(((2.inch * 3.inch) / 3.inch).value(in: .inch) - 2) < 1e-12)
    }

    /// Raw quantity operations retain scalar signs, zero, and IEEE division behavior.
    @Test
    func preservesScalarEdgeCases() {
        #expect((0.meter * 1.meter).value(in: .squareMeter) == 0)
        #expect(((-2).meter * 3.meter).value(in: .squareMeter) == -6)
        #expect((1.m2 / 0.meter).value(in: .meter) == Double.infinity)
        #expect((0.m2 / 0.meter).value(in: .meter).isNaN)
    }
}
