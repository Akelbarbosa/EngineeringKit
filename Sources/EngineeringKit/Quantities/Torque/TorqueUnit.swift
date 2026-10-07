//
//  TorqueUnit.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Supported units for expressing torque.
public enum TorqueUnit: Sendable {
    /// SI unit of torque (N·m).
    case newtonMeter
    /// One thousand newton-meters (kN·m).
    case kilonewtonMeter
}
