//
//  EnglishUnitsTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Checks international inch-pound conversions and calculations across systems.
@Suite("English Unit Tests")
struct EnglishUnitsTests {
    /// Compares numerical results using a relative tolerance for Double rounding.
    private func isClose(_ actual: Double, _ expected: Double) -> Bool {
        abs(actual - expected) <= max(1, abs(expected)) * 1e-12
    }

    /// Length definitions match the international inch, foot, and yard.
    @Test
    func convertsEnglishLengthsToSI() {
        #expect(isClose(1.inch.value(in: .millimeter), 25.4))
        #expect(isClose(1.foot.value(in: .meter), 0.3048))
        #expect(isClose(1.yard.value(in: .meter), 0.9144))
        #expect(isClose(25.4.millimeter.value(in: .inch), 1))
        #expect(isClose(0.3048.meter.value(in: .foot), 1))
        #expect(isClose(0.9144.meter.value(in: .yard), 1))
    }

    /// Pound-force uses standard gravity, and a kip contains one thousand lbf.
    @Test
    func convertsEnglishForcesToSI() {
        #expect(isClose(1.lbf.value(in: .newton), 4.4482216152605))
        #expect(isClose(1.kip.value(in: .newton), 4448.2216152605))
        #expect(isClose(4.4482216152605.newton.value(in: .poundForce), 1))
        #expect(isClose(4448.2216152605.newton.value(in: .kip), 1))
        #expect(isClose(1.kip.value(in: .poundForce), 1000))
    }

    /// Torque reference values use force multiplied by the perpendicular arm.
    @Test
    func convertsEnglishTorquesToSI() {
        #expect(isClose(1.lbfInch.value(in: .newtonMeter), 0.1129848290276167))
        #expect(isClose(1.lbfFoot.value(in: .newtonMeter), 1.3558179483314004))
        #expect(isClose(1.kipInch.value(in: .newtonMeter), 112.9848290276167))
        #expect(isClose(1.kipFoot.value(in: .newtonMeter), 1355.8179483314004))
        #expect(isClose(0.1129848290276167.newtonMeter.value(in: .poundForceInch), 1))
        #expect(isClose(1.3558179483314004.newtonMeter.value(in: .poundForceFoot), 1))
        #expect(isClose(112.9848290276167.newtonMeter.value(in: .kipInch), 1))
        #expect(isClose(1355.8179483314004.newtonMeter.value(in: .kipFoot), 1))
    }

    /// Density converts pound-mass and cubed length; it does not apply gravity.
    @Test
    func convertsEnglishMassDensitiesToSI() {
        #expect(isClose(1.lbmPerCubicFoot.value(in: .kilogramPerCubicMeter), 16.01846337396014))
        #expect(isClose(1.lbmPerCubicInch.value(in: .kilogramPerCubicMeter), 27679.904710203125))
        #expect(isClose(16.01846337396014.kgPerCubicMeter.value(in: .poundMassPerCubicFoot), 1))
        #expect(isClose(27679.904710203125.kgPerCubicMeter.value(in: .poundMassPerCubicInch), 1))
        #expect(isClose(1.lbmPerCubicInch.value(in: .poundMassPerCubicFoot), 1728))
    }

    /// Signed, zero, and fractional lengths survive conversion through SI.
    @Test(arguments: [LengthUnit.inch, .foot, .yard])
    func roundTripsEnglishLengths(unit: LengthUnit) {
        for value in [0.0, -2.5, 0.125, 1_000_000] {
            let quantity = Length(value: value, unit: unit)
            let restored = Length(value: quantity.value(in: .meter), unit: .meter)
            #expect(isClose(restored.value(in: unit), value))
        }
    }

    /// Signed, zero, and fractional forces survive conversion through SI.
    @Test(arguments: [ForceUnit.poundForce, .kip])
    func roundTripsEnglishForces(unit: ForceUnit) {
        for value in [0.0, -2.5, 0.125, 1_000_000] {
            let quantity = Force(value: value, unit: unit)
            let restored = Force(value: quantity.value(in: .newton), unit: .newton)
            #expect(isClose(restored.value(in: unit), value))
        }
    }

    /// Signed, zero, and fractional torques survive conversion through SI.
    @Test(arguments: [TorqueUnit.poundForceInch, .poundForceFoot, .kipInch, .kipFoot])
    func roundTripsEnglishTorques(unit: TorqueUnit) {
        for value in [0.0, -2.5, 0.125, 1_000_000] {
            let quantity = Torque(value: value, unit: unit)
            let restored = Torque(value: quantity.value(in: .newtonMeter), unit: .newtonMeter)
            #expect(isClose(restored.value(in: unit), value))
        }
    }

    /// Density retains scalar values in both supported pound-mass units.
    @Test(arguments: [DensityUnit.poundMassPerCubicFoot, .poundMassPerCubicInch])
    func roundTripsEnglishDensities(unit: DensityUnit) {
        for value in [0.0, -2.5, 0.125, 1_000_000] {
            let quantity = Density(value: value, unit: unit)
            let restored = Density(value: quantity.value(in: .kilogramPerCubicMeter), unit: .kilogramPerCubicMeter)
            #expect(isClose(restored.value(in: unit), value))
        }
    }

    /// Arithmetic and ordering work between SI and inch-pound inputs.
    @Test
    func calculatesAcrossUnitSystems() {
        #expect(isClose((1.foot + 25.4.millimeter).value(in: .inch), 13))
        #expect(1.foot > 25.4.millimeter)
        #expect(isClose((1.kip - 4.4482216152605.newton).value(in: .poundForce), 999))
        #expect(1.kip > 1.knewton)
        #expect(isClose((1.lbfFoot + 0.1129848290276167.newtonMeter).value(in: .poundForceInch), 13))
        #expect(isClose((1.lbmPerCubicFoot + 16.01846337396014.kgPerCubicMeter).value(in: .poundMassPerCubicFoot), 2))
    }

    /// Inch and foot torque units agree with the typed force–length operators.
    @Test
    func computesEnglishAndMixedSystemMoments() {
        #expect(isClose((2.lbf * 6.inch).value(in: .poundForceFoot), 1))
        #expect(isClose((6.inch * 2.lbf).value(in: .poundForceInch), 12))
        #expect(isClose((2.kip * 6.inch).value(in: .kipFoot), 1))
        #expect(isClose((2.kip * 6.inch).value(in: .kipInch), 12))
        #expect(isClose((1.lbf * 0.3048.meter).value(in: .poundForceFoot), 1))
        #expect(isClose((4.4482216152605.newton * 1.foot).value(in: .poundForceFoot), 1))
    }

    /// Every new shorthand works for decimal literals as well as integers.
    @Test
    func supportsFractionalEnglishShorthand() {
        #expect(isClose(2.5.inch.value(in: .inch), 2.5))
        #expect(isClose(2.5.foot.value(in: .foot), 2.5))
        #expect(isClose(2.5.yard.value(in: .yard), 2.5))
        #expect(isClose(2.5.lbf.value(in: .poundForce), 2.5))
        #expect(isClose(2.5.kip.value(in: .kip), 2.5))
        #expect(isClose(2.5.lbfInch.value(in: .poundForceInch), 2.5))
        #expect(isClose(2.5.lbfFoot.value(in: .poundForceFoot), 2.5))
        #expect(isClose(2.5.kipInch.value(in: .kipInch), 2.5))
        #expect(isClose(2.5.kipFoot.value(in: .kipFoot), 2.5))
        #expect(isClose(2.5.lbmPerCubicFoot.value(in: .poundMassPerCubicFoot), 2.5))
        #expect(isClose(2.5.lbmPerCubicInch.value(in: .poundMassPerCubicInch), 2.5))
    }
}
