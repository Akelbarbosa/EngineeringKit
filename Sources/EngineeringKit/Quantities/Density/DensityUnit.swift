//
//  DensityUnit.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Supported units for expressing mass density.
public enum DensityUnit: Sendable {
    /// SI unit of mass density (kg/m³).
    case kilogramPerCubicMeter
    /// One thousand kilograms per cubic meter (g/cm³).
    case gramPerCubicCentimeter
}
