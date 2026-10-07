//
//  main.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import EngineeringKit

// These preconditions exercise public APIs from a separate consumer package.
let moment = 2.knewton * 500.millimeter
precondition(abs(moment.value(in: .kilonewtonMeter) - 1) < 1e-12)
let section = try RectangularSection(width: 2.inch, height: 6.inch)
precondition(abs(section.area.value(in: .squareInch) - 12) < 1e-12)
precondition(abs(section.secondMomentOfAreaX.value(in: .inchToFourthPower) - 36) < 1e-12)
let shifted = try section.secondMomentOfAreaX(offsetY: (-3).inch)
precondition(abs(shifted.value(in: .inchToFourthPower) - 144) < 1e-10)
let pipe = try HollowCircularSection(outerDiameter: 4.inch, innerDiameter: 2.inch)
precondition(abs(pipe.area.value(in: .squareInch) - 3 * Double.pi) < 1e-12)
print("EngineeringKit consumer passed: mixed units, rectangle, tube, and parallel axes.")
