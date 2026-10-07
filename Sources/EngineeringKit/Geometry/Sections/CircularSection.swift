//
//  CircularSection.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// A solid circular cross-section with orthogonal axes through its center.
///
/// The local origin is the lower-left corner of its bounding square, so the
/// centroid coordinates both equal the radius.
public struct CircularSection: PlaneSection, Equatable {
    /// The positive outer diameter.
    public let diameter: Length

    /// Creates a circle from a positive, finite diameter in any length unit.
    /// - Throws: SectionGeometryError.invalidDimension for an invalid diameter.
    public init(diameter: Length) throws {
        let d = diameter.value(in: .meter)
        guard d.isFinite && d > 0 else {
            throw SectionGeometryError.invalidDimension(name: "diameter")
        }
        self.diameter = diameter
    }

    /// Distance from the center to the outer boundary.
    public var radius: Length { diameter / 2 }

    /// Cross-sectional area A = πd² / 4.
    public var area: Area {
        let d = diameter.value(in: .meter)
        return Area(value: Double.pi * d * d / 4, unit: .squareMeter)
    }

    /// Horizontal centroid coordinate relative to the bounding square.
    public var centroidX: Length { radius }

    /// Vertical centroid coordinate relative to the bounding square.
    public var centroidY: Length { radius }

    /// Centroidal horizontal moment Ix = πd⁴ / 64.
    public var secondMomentOfAreaX: SecondMomentOfArea {
        let d = diameter.value(in: .meter)
        return SecondMomentOfArea(value: Double.pi * d * d * d * d / 64,
                                  unit: .meterToFourthPower)
    }

    /// Centroidal vertical moment, equal to Ix by circular symmetry.
    public var secondMomentOfAreaY: SecondMomentOfArea { secondMomentOfAreaX }

    /// Elastic section modulus Sx = Ix / radius.
    public var sectionModulusX: SectionModulus { secondMomentOfAreaX / radius }

    /// Elastic section modulus Sy = Iy / radius.
    public var sectionModulusY: SectionModulus { sectionModulusX }
}
