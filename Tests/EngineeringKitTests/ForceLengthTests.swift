//
//  ForceLengthTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Verifies conversions and operations for the quantities in this suite.
@Suite("Force × Length Tests")
struct ForceLengthTests {
    /// Computes the same torque in either operand order with mixed units.
    @Test
    func computesMomentWithMixedUnits() {
        let force = Force(value: 10, unit: .kilonewton)
        let length = Length(value: 2_000, unit: .millimeter)
        let moment = force * length
        #expect(moment.value(in: .newtonMeter) == 20_000)
        #expect(moment.value(in: .kilonewtonMeter) == 20)
        #expect(length * force == moment)
    }

    /// Propagates the signed perpendicular lever arm into the torque.
    @Test(arguments: [0.0, -2.0, 0.125])
    func respectsLeverArmSignAndMagnitude(arm: Double) {
        let moment = Force(value: 10, unit: .newton) * Length(value: arm, unit: .meter)
        #expect(moment.value(in: .newtonMeter) == 10 * arm)
    }

    /// Propagates negative and zero force into the torque.
    @Test
    func respectsForceSignAndZero() {
        let arm = Length(value: 2, unit: .meter)
        #expect((Force(value: -10, unit: .newton) * arm).value(in: .newtonMeter) == -20)
        #expect((Force(value: 0, unit: .newton) * arm).value(in: .newtonMeter) == 0)
    }
}
