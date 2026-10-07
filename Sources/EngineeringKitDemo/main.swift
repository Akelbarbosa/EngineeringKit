//
//  main.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 5/10/26.
//

import Foundation
import EngineeringKit

// Numeric shorthand constructs typed forces in different units.
let force1 = 10.knewton
let force2 = 2_000.newton

// Arithmetic automatically operates on the canonical SI values.
let sum = force1 + force2
let difference = force1 - force2
let doubled = force1 * 2
let half = force1 / 2

print("Sum:", sum.value(in: .kilonewton), "kN")
print("Difference:", difference.value(in: .kilonewton), "kN")
print("Doubled:", doubled.value(in: .kilonewton), "kN")
print("Half:", half.value(in: .kilonewton), "kN")

// The distance represents a perpendicular lever arm.
let distance = 2.meter
let moment = force1 * distance

print("Lever arm:", distance.value(in: .millimeter), "mm")
print("Moment:", moment.value(in: .kilonewtonMeter), "kN·m")

// Density shorthand converts grams per cubic centimeter to its SI representation.
let density = 1.gPerCubicCentimeter
print("Density:", density.value(in: .kilogramPerCubicMeter), "kg/m³")

// International inch-pound inputs can be mixed with SI quantities.
let englishArm = 12.inch
let englishForce = 2.kip
let englishMoment = englishForce * englishArm
print("English lever arm:", englishArm.value(in: .millimeter), "mm")
print("English moment:", englishMoment.value(in: .kipFoot), "kip·ft")
print("Mass density:", 1.lbmPerCubicFoot.value(in: .kilogramPerCubicMeter), "kg/m³")
