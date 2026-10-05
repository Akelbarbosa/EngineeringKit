//
//  Force.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 5/10/26.
//

import Foundation

public struct Force: Sendable {
    private let valueInNewtons: Double

    public init(value: Double, unit: ForceUnit) {
        switch unit {
        case .newton:
            self.valueInNewtons = value

        case .kilonewton:
            self.valueInNewtons = value * 1_000
        }
    }
    
    public func value(in unit: ForceUnit) -> Double {
        switch unit {
        case .newton:
            return valueInNewtons

        case .kilonewton:
            return valueInNewtons / 1_000
        }
    }
}
