//
//  CircularSectionTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Checks circular symmetry, independent reference values, units, and validation.
@Suite("Circular Section Tests")
struct CircularSectionTests {
    /// Allows rounding in unit conversions while preserving relative accuracy.
    private func isClose(_ actual: Double, _ expected: Double) -> Bool {
        abs(actual - expected) <= max(abs(expected) * 1e-12, 1e-24)
    }

    /// A two-inch diameter yields π in² area, π/4 in⁴ inertia, and π/4 in³ modulus.
    @Test
    func referenceProperties() throws {
        let circle = try CircularSection(diameter: 2.inch)
        #expect(circle.radius == 1.inch)
        #expect(circle.centroidX == 1.inch)
        #expect(circle.centroidY == 1.inch)
        #expect(isClose(circle.area.value(in: .squareInch), Double.pi))
        #expect(isClose(circle.secondMomentOfAreaX.value(in: .inchToFourthPower), Double.pi / 4))
        #expect(circle.secondMomentOfAreaX == circle.secondMomentOfAreaY)
        #expect(isClose(circle.sectionModulusX.value(in: .cubicInch), Double.pi / 4))
        #expect(circle.sectionModulusX == circle.sectionModulusY)
        #expect(isClose(circle.polarMomentOfArea.value(in: .inchToFourthPower), Double.pi / 2))
        #expect(isClose(circle.radiusOfGyrationX.value(in: .inch), 0.5))
        #expect(isClose(circle.radiusOfGyrationY.value(in: .inch), 0.5))
    }

    /// Metric input represents the same circle; doubling scales A, I, and S correctly.
    @Test
    func unitsAndScaling() throws {
        let metric = try CircularSection(diameter: 50.8.millimeter)
        let circle = try CircularSection(diameter: 2.inch)
        let doubled = try CircularSection(diameter: 4.inch)
        #expect(isClose(metric.area.value(in: .squareInch), Double.pi))
        #expect(isClose(metric.secondMomentOfAreaX.value(in: .inchToFourthPower), Double.pi / 4))
        #expect(isClose(doubled.area.value(in: .squareInch) / circle.area.value(in: .squareInch), 4))
        #expect(isClose(doubled.secondMomentOfAreaX.value(in: .inchToFourthPower) / circle.secondMomentOfAreaX.value(in: .inchToFourthPower), 16))
        #expect(isClose(doubled.sectionModulusX.value(in: .cubicInch) / circle.sectionModulusX.value(in: .cubicInch), 8))
    }

    /// Zero, negative, and non-finite diameters cannot describe a solid circle.
    @Test(arguments: [0.0, -1.0, Double.nan, Double.infinity, -Double.infinity])
    func rejectsDiameter(value: Double) {
        #expect(throws: SectionGeometryError.invalidDimension(name: "diameter")) {
            _ = try CircularSection(diameter: value.meter)
        }
    }
}
