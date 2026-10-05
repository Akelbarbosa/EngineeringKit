//
//  main.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 5/10/26.
//

import Foundation
import EngineeringKit

let force = Force(value: 10, unit: .kilonewton)

print("Force in kN:", force.value(in: .kilonewton))
print("Force in N:", force.value(in: .newton))
