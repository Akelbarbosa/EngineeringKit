//
//  PlaneSectionTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Checks shared geometry properties and signed parallel-axis distances.
@Suite("Plane Section Tests")
struct PlaneSectionTests {
    /// Allows unit conversion rounding in independent reference results.
    private func isClose(_ actual: Double, _ expected: Double) -> Bool {
        abs(actual - expected) <= max(abs(expected) * 1e-12, 1e-24)
    }

    /// Rectangle gyration radii are h/sqrt(12) and b/sqrt(12), with J = 40 in⁴.
    @Test
    func commonProperties() throws {
        let section: any PlaneSection = try RectangularSection(width: 2.inch, height: 6.inch)
        #expect(isClose(section.polarMomentOfArea.value(in: .inchToFourthPower), 40))
        #expect(isClose(section.radiusOfGyrationX.value(in: .inch), 3.0.squareRoot()))
        #expect(isClose(section.radiusOfGyrationY.value(in: .inch), 1 / 3.0.squareRoot()))
        // The base and left edge are at offsets -h/2 and -b/2 from the centroid.
        #expect(isClose(try section.secondMomentOfAreaX(offsetY: (-3).inch).value(in: .inchToFourthPower), 144))
        #expect(isClose(try section.secondMomentOfAreaY(offsetX: (-1).inch).value(in: .inchToFourthPower), 16))
        #expect(try section.secondMomentOfAreaX(offsetY: 0.meter) == section.secondMomentOfAreaX)
        #expect(try section.secondMomentOfAreaY(offsetX: 0.meter) == section.secondMomentOfAreaY)
        #expect(isClose(try section.secondMomentOfAreaX(offsetY: 76.2.millimeter).value(in: .inchToFourthPower), 144))
        #expect(isClose(try section.secondMomentOfAreaY(offsetX: 25.4.millimeter).value(in: .inchToFourthPower), 16))
    }

    /// All section shapes work through the shared interface and retain I = A k².
    @Test
    func sharedInterface() throws {
        let sections: [any PlaneSection] = [
            try RectangularSection(width: 2.meter, height: 3.meter),
            try CircularSection(diameter: 2.meter),
            try HollowCircularSection(outerDiameter: 2.meter, innerDiameter: 1.meter),
            try HollowRectangularSection(width: 2.meter, height: 3.meter, wallThickness: 0.1.meter)
        ]
        for section in sections {
            let a = section.area.value(in: .squareMeter)
            let kx = section.radiusOfGyrationX.value(in: .meter)
            let ky = section.radiusOfGyrationY.value(in: .meter)
            #expect(isClose(a * kx * kx, section.secondMomentOfAreaX.value(in: .meterToFourthPower)))
            #expect(isClose(a * ky * ky, section.secondMomentOfAreaY.value(in: .meterToFourthPower)))
            #expect(isClose(try section.secondMomentOfAreaX(offsetY: (-1).meter).value(in: .meterToFourthPower), section.secondMomentOfAreaX.value(in: .meterToFourthPower) + a))
            #expect(isClose(try section.secondMomentOfAreaY(offsetX: 1.meter).value(in: .meterToFourthPower), section.secondMomentOfAreaY.value(in: .meterToFourthPower) + a))
        }
    }

    /// Non-finite offsets fail without changing the valid treatment of signed distances.
    @Test(arguments: [Double.nan, Double.infinity, -Double.infinity])
    func invalidOffsets(value: Double) throws {
        let section = try CircularSection(diameter: 1.meter)
        #expect(throws: SectionGeometryError.nonFiniteOffset(name: "offsetY")) {
            _ = try section.secondMomentOfAreaX(offsetY: value.meter)
        }
        #expect(throws: SectionGeometryError.nonFiniteOffset(name: "offsetX")) {
            _ = try section.secondMomentOfAreaY(offsetX: value.meter)
        }
    }
}
