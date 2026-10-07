//
//  EngineeringKitTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
@testable import EngineeringKit

/// Verifies conversions and operations for the quantities in this suite.
@Suite("Force Tests")
struct ForceTests {

    /// Converts kilonewtons to their canonical SI value.
    @Test
    func convertsKilonewtonsToNewtons() {
        let force = Force(value: 10, unit: .kilonewton)

        #expect(force.value(in: .newton) == 10_000)
    }

    /// Converts SI force values to kilonewtons.
    @Test
    func convertsNewtonsToKilonewtons() {
        let force = Force(value: 1_500, unit: .newton)

        #expect(force.value(in: .kilonewton) == 1.5)
    }

    /// Keeps the numeric value when requesting the original unit.
    @Test
    func preservesValueInSameUnit() {
        let force = Force(value: 250, unit: .newton)

        #expect(force.value(in: .newton) == 250)
    }

    /// Recognizes equal forces expressed in different units.
    @Test
    func comparesEquivalentForces() {
        let oneKilonewton = Force(value: 1, unit: .kilonewton)
        let oneThousandNewtons = Force(value: 1_000, unit: .newton)

        #expect(oneKilonewton == oneThousandNewtons)
    }

    /// Orders force values after normalizing their units.
    @Test
    func comparesForceMagnitude() {
        let greater = Force(value: 2, unit: .kilonewton)
        let smaller = Force(value: 1_500, unit: .newton)

        #expect(greater > smaller)
    }

    /// Adds forces expressed in different units.
    @Test
    func addsForces() {
        let lhs = Force(value: 10, unit: .kilonewton)
        let rhs = Force(value: 2_000, unit: .newton)

        let result = lhs + rhs

        #expect(result.value(in: .kilonewton) == 12)
    }

    /// Subtracts forces expressed in different units.
    @Test
    func subtractsForces() {
        let lhs = Force(value: 10, unit: .kilonewton)
        let rhs = Force(value: 2_000, unit: .newton)

        let result = lhs - rhs

        #expect(result.value(in: .kilonewton) == 8)
    }

    /// Scales a force without changing its physical dimension.
    @Test
    func multipliesForceByScalar() {
        let force = Force(value: 10, unit: .kilonewton)

        let result = force * 2

        #expect(result.value(in: .kilonewton) == 20)
    }

    /// Divides a force by a dimensionless scalar.
    @Test
    func dividesForceByScalar() {
        let force = Force(value: 10, unit: .kilonewton)

        let result = force / 2

        #expect(result.value(in: .kilonewton) == 5)
    }
}
