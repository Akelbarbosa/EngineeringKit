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
    /// The inner diameter must be strictly smaller than the outer diameter.
    case invalidDiameterRelationship

    /// The wall must leave a positive, representable rectangular opening.
    case invalidWallThickness

    /// The named axis offset must be finite; zero and negative values are valid.
    case nonFiniteOffset(name: String)
}
