//
//  QuantityLiteralsTests.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import Testing
import EngineeringKit

/// Verifies the public numeric syntax, including its SI conversion and type.
@Suite("Quantity Literal Tests")
struct QuantityLiteralsTests {
    /// Integer literals construct each supported engineering quantity.
    @Test
    func constructsQuantitiesFromIntegers() {
        #expect(2.newton == Force(value: 2, unit: .newton))
        #expect(2.knewton.value(in: .newton) == 2_000)
        #expect(2.meter == Length(value: 2, unit: .meter))
        #expect(2.millimeter.value(in: .meter) == 0.002)
        #expect(2.newtonMeter == Torque(value: 2, unit: .newtonMeter))
        #expect(2.knewtonMeter.value(in: .newtonMeter) == 2_000)
    }

    /// Decimal literals preserve their fractional part in each unit.
    @Test
    func constructsQuantitiesFromDecimals() {
        #expect(2.5.newton.value(in: .newton) == 2.5)
        #expect(2.5.knewton.value(in: .newton) == 2_500)
        #expect(2.5.meter.value(in: .meter) == 2.5)
        #expect(2.5.millimeter.value(in: .meter) == 0.0025)
        #expect(2.5.newtonMeter.value(in: .newtonMeter) == 2.5)
        #expect(2.5.knewtonMeter.value(in: .newtonMeter) == 2_500)
    }

    /// The shorthand applies to numeric variables as well as literals.
    @Test
    func supportsNumericVariableTypes() {
        let integer: Int8 = 2
        let unsigned: UInt = 2
        let decimal: Float = 2.5
        #expect(integer.knewton == 2.knewton)
        #expect(unsigned.meter == 2.meter)
        #expect(decimal.knewtonMeter == 2.5.knewtonMeter)
    }

    /// Signs and zero follow the underlying scalar quantity semantics.
    @Test
    func preservesSignedAndZeroValues() {
        #expect((-2).knewton.value(in: .newton) == -2_000)
        #expect((-0.5).meter.value(in: .millimeter) == -500)
        #expect(0.newtonMeter.value(in: .newtonMeter) == 0)
    }

    /// A force and perpendicular lever arm yield a typed torque in either order.
    @Test
    func computesMomentUsingShorthand() {
        let moment: Torque = 2.knewton * 500.millimeter
        #expect(moment == 1.knewtonMeter)
        #expect(500.millimeter * 2.knewton == moment)
    }
}
