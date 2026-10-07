//
//  SectionGeometryError.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Errors encountered when constructing a physical section geometry.
public enum SectionGeometryError: Error, Equatable, Sendable {
    /// The named dimension must be strictly positive and finite in SI units.
    case invalidDimension(name: String)
}
