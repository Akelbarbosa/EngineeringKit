//
//  HollowSectionTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Checks hollow sections against solid subtraction and dimension constraints.
@Suite("Hollow Section Tests")
struct HollowSectionTests {
    /// Supports metric and English conversion rounding.
    private func isClose(_ actual: Double, _ expected: Double) -> Bool {
        abs(actual - expected) <= max(abs(expected) * 1e-12, 1e-24)
    }

    /// A concentric 4/2-inch tube has 3π area and 15π/4 centroidal inertia.
    @Test
    func circularReference() throws {
        let tube = try HollowCircularSection(outerDiameter: 4.inch, innerDiameter: 50.8.millimeter)
        #expect(isClose(tube.wallThickness.value(in: .inch), 1))
        #expect(tube.centroidX == 2.inch)
        #expect(tube.centroidY == 2.inch)
        #expect(isClose(tube.area.value(in: .squareInch), 3 * Double.pi))
        #expect(isClose(tube.secondMomentOfAreaX.value(in: .inchToFourthPower), 15 * Double.pi / 4))
        #expect(tube.secondMomentOfAreaY == tube.secondMomentOfAreaX)
        #expect(isClose(tube.sectionModulusX.value(in: .cubicInch), 15 * Double.pi / 8))
        #expect(tube.sectionModulusY == tube.sectionModulusX)
        #expect(isClose(tube.radiusOfGyrationX.value(in: .inch), 5.0.squareRoot() / 2))
    }

    /// An 8 × 6-inch tube with 1-inch walls removes a centered 6 × 4 rectangle.
    @Test
    func rectangularReference() throws {
        let tube = try HollowRectangularSection(width: 8.inch, height: 152.4.millimeter, wallThickness: 1.inch)
        #expect(isClose(tube.innerWidth.value(in: .inch), 6))
        #expect(isClose(tube.innerHeight.value(in: .inch), 4))
        #expect(isClose(tube.area.value(in: .squareInch), 24))
        #expect(isClose(tube.centroidX.value(in: .inch), 4))
        #expect(isClose(tube.centroidY.value(in: .inch), 3))
        #expect(isClose(tube.secondMomentOfAreaX.value(in: .inchToFourthPower), 112))
        #expect(isClose(tube.secondMomentOfAreaY.value(in: .inchToFourthPower), 184))
        #expect(isClose(tube.sectionModulusX.value(in: .cubicInch), 112.0 / 3))
        #expect(isClose(tube.sectionModulusY.value(in: .cubicInch), 46))
        let rotated = try HollowRectangularSection(width: 6.inch, height: 8.inch, wallThickness: 1.inch)
        #expect(isClose(rotated.secondMomentOfAreaX.value(in: .inchToFourthPower), 184))
        #expect(isClose(rotated.secondMomentOfAreaY.value(in: .inchToFourthPower), 112))
    }

    /// A thin-wall square keeps meaningful area and moment without cancellation.
    @Test
    func thinWallRectangle() throws {
        let tube = try HollowRectangularSection(width: 1.meter, height: 1.meter, wallThickness: 1e-10.meter)
        #expect(isClose(tube.area.value(in: .squareMeter), 3.9999999996e-10))
        #expect(isClose(tube.secondMomentOfAreaX.value(in: .meterToFourthPower), 6.666666664666667e-11))
    }

    /// A ring equals outer solid properties minus the concentric inner solid.
    @Test
    func circularSubtractionAndScaling() throws {
        let outer = try CircularSection(diameter: 100.millimeter)
        let inner = try CircularSection(diameter: 80.millimeter)
        let tube = try HollowCircularSection(outerDiameter: outer.diameter, innerDiameter: inner.diameter)
        let doubled = try HollowCircularSection(outerDiameter: 200.millimeter, innerDiameter: 160.millimeter)
        #expect(isClose(tube.area.value(in: .squareMeter), (outer.area - inner.area).value(in: .squareMeter)))
        #expect(isClose(tube.secondMomentOfAreaX.value(in: .meterToFourthPower), (outer.secondMomentOfAreaX - inner.secondMomentOfAreaX).value(in: .meterToFourthPower)))
        #expect(isClose(doubled.area.value(in: .squareMeter) / tube.area.value(in: .squareMeter), 4))
        #expect(isClose(doubled.secondMomentOfAreaX.value(in: .meterToFourthPower) / tube.secondMomentOfAreaX.value(in: .meterToFourthPower), 16))
        #expect(isClose(doubled.sectionModulusX.value(in: .cubicMeter) / tube.sectionModulusX.value(in: .cubicMeter), 8))
    }

    /// Each hollow-section dimension rejects non-positive or non-finite inputs.
    @Test(arguments: [0.0, -1.0, Double.nan, Double.infinity, -Double.infinity])
    func invalidDimensions(value: Double) {
        #expect(throws: SectionGeometryError.invalidDimension(name: "outerDiameter")) {
            _ = try HollowCircularSection(outerDiameter: value.meter, innerDiameter: 1.meter)
        }
        #expect(throws: SectionGeometryError.invalidDimension(name: "innerDiameter")) {
            _ = try HollowCircularSection(outerDiameter: 2.meter, innerDiameter: value.meter)
        }
        #expect(throws: SectionGeometryError.invalidDimension(name: "width")) {
            _ = try HollowRectangularSection(width: value.meter, height: 2.meter, wallThickness: 0.1.meter)
        }
        #expect(throws: SectionGeometryError.invalidDimension(name: "height")) {
            _ = try HollowRectangularSection(width: 2.meter, height: value.meter, wallThickness: 0.1.meter)
        }
        #expect(throws: SectionGeometryError.invalidDimension(name: "wallThickness")) {
            _ = try HollowRectangularSection(width: 2.meter, height: 2.meter, wallThickness: value.meter)
        }
    }

    /// An opening must remain inside the outer boundary with positive material.
    @Test
    func invalidRelationships() {
        for diameter in [2.meter, 3.meter] {
            #expect(throws: SectionGeometryError.invalidDiameterRelationship) {
                _ = try HollowCircularSection(outerDiameter: 2.meter, innerDiameter: diameter)
            }
        }
        for thickness in [1.meter, 1.1.meter, 1e-30.meter] {
            #expect(throws: SectionGeometryError.invalidWallThickness) {
                _ = try HollowRectangularSection(width: 2.meter, height: 4.meter, wallThickness: thickness)
            }
            #expect(throws: SectionGeometryError.invalidWallThickness) {
                _ = try HollowRectangularSection(width: 4.meter, height: 2.meter, wallThickness: thickness)
            }
        }
    }
}
