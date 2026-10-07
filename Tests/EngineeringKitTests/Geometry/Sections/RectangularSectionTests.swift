//
//  RectangularSectionTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Checks known section properties, axis orientation, scaling, and input validation.
@Suite("Rectangular Section Tests")
struct RectangularSectionTests {
    /// Allows floating-point conversion rounding without masking zero reference errors.
    private func isClose(_ actual: Double, _ expected: Double) -> Bool {
        abs(actual - expected) <= max(abs(expected) * 1e-12, 1e-24)
    }

    /// A 100 × 200 mm rectangle matches independent section-property values.
    @Test
    func computesMetricProperties() throws {
        let section = try RectangularSection(width: 100.millimeter, height: 200.millimeter)
        #expect(section.width == 100.millimeter)
        #expect(section.height == 200.millimeter)
        #expect(isClose(section.area.value(in: .squareMillimeter), 20_000))
        #expect(isClose(section.centroidX.value(in: .millimeter), 50))
        #expect(isClose(section.centroidY.value(in: .millimeter), 100))
        #expect(isClose(section.secondMomentOfAreaX.value(in: .millimeterToFourthPower), 66_666_666.66666667))
        #expect(isClose(section.secondMomentOfAreaY.value(in: .millimeterToFourthPower), 16_666_666.66666667))
        #expect(isClose(section.sectionModulusX.value(in: .cubicMillimeter), 666_666.6666666667))
        #expect(isClose(section.sectionModulusY.value(in: .cubicMillimeter), 333_333.3333333333))
    }

    /// A 2 × 6 inch rectangle distinguishes horizontal and vertical centroidal axes.
    @Test
    func computesEnglishProperties() throws {
        let section = try RectangularSection(width: 2.inch, height: 6.inch)
        #expect(isClose(section.area.value(in: .squareInch), 12))
        #expect(isClose(section.centroidX.value(in: .inch), 1))
        #expect(isClose(section.centroidY.value(in: .inch), 3))
        #expect(isClose(section.secondMomentOfAreaX.value(in: .inchToFourthPower), 36))
        #expect(isClose(section.secondMomentOfAreaY.value(in: .inchToFourthPower), 4))
        #expect(isClose(section.sectionModulusX.value(in: .cubicInch), 12))
        #expect(isClose(section.sectionModulusY.value(in: .cubicInch), 4))
    }

    /// Metric and English dimensions produce the same physical cross-section.
    @Test
    func acceptsMixedUnitDimensions() throws {
        let mixed = try RectangularSection(width: 2.inch, height: 152.4.millimeter)
        let english = try RectangularSection(width: 2.inch, height: 6.inch)
        #expect(isClose(mixed.area.value(in: .squareInch), english.area.value(in: .squareInch)))
        #expect(isClose(mixed.secondMomentOfAreaX.value(in: .inchToFourthPower), 36))
        #expect(isClose(mixed.secondMomentOfAreaY.value(in: .inchToFourthPower), 4))
        #expect(isClose(mixed.sectionModulusX.value(in: .cubicInch), 12))
        #expect(isClose(mixed.sectionModulusY.value(in: .cubicInch), 4))
    }

    /// Swapping width and height swaps the two centroidal axis properties.
    @Test
    func swapsAxesWhenRotated() throws {
        let original = try RectangularSection(width: 2.inch, height: 6.inch)
        let rotated = try RectangularSection(width: 6.inch, height: 2.inch)
        #expect(isClose(rotated.area.value(in: .squareInch), original.area.value(in: .squareInch)))
        #expect(isClose(rotated.secondMomentOfAreaX.value(in: .inchToFourthPower), original.secondMomentOfAreaY.value(in: .inchToFourthPower)))
        #expect(isClose(rotated.sectionModulusX.value(in: .cubicInch), original.sectionModulusY.value(in: .cubicInch)))
        #expect(isClose(rotated.secondMomentOfAreaY.value(in: .inchToFourthPower), original.secondMomentOfAreaX.value(in: .inchToFourthPower)))
    }

    /// A square has equal properties about both centroidal axes.
    @Test
    func computesSymmetricSquare() throws {
        let square = try RectangularSection(width: 2.meter, height: 2.meter)
        #expect(square.secondMomentOfAreaX == square.secondMomentOfAreaY)
        #expect(square.sectionModulusX == square.sectionModulusY)
        #expect(square.centroidX == square.centroidY)
        #expect(isClose(square.area.value(in: .squareMeter), 4))
    }

    /// Uniform doubling scales area by 4, inertia by 16, and section modulus by 8.
    @Test
    func followsGeometricScaling() throws {
        let original = try RectangularSection(width: 2.inch, height: 6.inch)
        let doubled = try RectangularSection(width: 4.inch, height: 12.inch)
        #expect(isClose(doubled.area.value(in: .squareInch) / original.area.value(in: .squareInch), 4))
        #expect(isClose(doubled.secondMomentOfAreaX.value(in: .inchToFourthPower) / original.secondMomentOfAreaX.value(in: .inchToFourthPower), 16))
        #expect(isClose(doubled.secondMomentOfAreaY.value(in: .inchToFourthPower) / original.secondMomentOfAreaY.value(in: .inchToFourthPower), 16))
        #expect(isClose(doubled.sectionModulusX.value(in: .cubicInch) / original.sectionModulusX.value(in: .cubicInch), 8))
        #expect(isClose(doubled.sectionModulusY.value(in: .cubicInch) / original.sectionModulusY.value(in: .cubicInch), 8))
    }

    /// Invalid widths fail with a recoverable, dimension-specific error.
    @Test(arguments: [0.0, -0.0, -1.0, Double.nan, Double.infinity, -Double.infinity])
    func rejectsInvalidWidth(value: Double) {
        #expect(throws: SectionGeometryError.invalidDimension(name: "width")) {
            _ = try RectangularSection(width: value.meter, height: 1.meter)
        }
    }

    /// Invalid heights fail with a recoverable, dimension-specific error.
    @Test(arguments: [0.0, -0.0, -1.0, Double.nan, Double.infinity, -Double.infinity])
    func rejectsInvalidHeight(value: Double) {
        #expect(throws: SectionGeometryError.invalidDimension(name: "height")) {
            _ = try RectangularSection(width: 1.meter, height: value.meter)
        }
    }
}
