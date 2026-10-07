//
//  HollowRectangularSection.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// A rectangular tube with concentric opening, uniform walls, and sharp corners.
///
/// Width is along x and height along y. The local origin is the lower-left
/// outer corner; property axes pass through the centroid. Rounded corners of
/// manufactured hollow structural sections are not represented by this model.
public struct HollowRectangularSection: PlaneSection, Equatable {
    /// Outer horizontal dimension b.
    public let width: Length
    /// Outer vertical dimension h.
    public let height: Length
    /// Uniform positive wall thickness t.
    public let wallThickness: Length

    /// Creates a tube with positive, finite dimensions and an open interior.
    /// - Throws: SectionGeometryError for invalid dimensions or a wall that
    ///   does not leave a positive, representable opening in both directions.
    public init(width: Length, height: Length, wallThickness: Length) throws {
        let b = width.value(in: .meter)
        let h = height.value(in: .meter)
        let t = wallThickness.value(in: .meter)
        guard b.isFinite && b > 0 else {
            throw SectionGeometryError.invalidDimension(name: "width")
        }
        guard h.isFinite && h > 0 else {
            throw SectionGeometryError.invalidDimension(name: "height")
        }
        guard t.isFinite && t > 0 else {
            throw SectionGeometryError.invalidDimension(name: "wallThickness")
        }
        guard t < b / 2 && t < h / 2,
              b - 2 * t < b, h - 2 * t < h else {
            throw SectionGeometryError.invalidWallThickness
        }
        self.width = width
        self.height = height
        self.wallThickness = wallThickness
    }

    /// Horizontal dimension of the opening, bi = b - 2t.
    public var innerWidth: Length { width - wallThickness * 2 }
    /// Vertical dimension of the opening, hi = h - 2t.
    public var innerHeight: Length { height - wallThickness * 2 }

    /// Material area A = bh - bi × hi, evaluated as 2t × (b + hi).
    public var area: Area { (wallThickness * 2) * (width + innerHeight) }
    /// Horizontal centroid coordinate b / 2.
    public var centroidX: Length { width / 2 }
    /// Vertical centroid coordinate h / 2.
    public var centroidY: Length { height / 2 }

    /// Centroidal moment Ix = (bh³ - bi × hi³) / 12.
    public var secondMomentOfAreaX: SecondMomentOfArea {
        let b = width.value(in: .meter)
        let h = height.value(in: .meter)
        let hi = innerHeight.value(in: .meter)
        let t = wallThickness.value(in: .meter)
        // Factor the difference of cubes to avoid subtracting nearly equal moments.
        return SecondMomentOfArea(value: 2 * t * (b * (h * h + h * hi + hi * hi)
            + hi * hi * hi) / 12, unit: .meterToFourthPower)
    }

    /// Centroidal moment Iy = (hb³ - hi × bi³) / 12.
    public var secondMomentOfAreaY: SecondMomentOfArea {
        let b = width.value(in: .meter)
        let h = height.value(in: .meter)
        let bi = innerWidth.value(in: .meter)
        let t = wallThickness.value(in: .meter)
        // Interchange horizontal and vertical dimensions in the factored formula.
        return SecondMomentOfArea(value: 2 * t * (h * (b * b + b * bi + bi * bi)
            + bi * bi * bi) / 12, unit: .meterToFourthPower)
    }

    /// Elastic modulus about x using the outer fiber, Sx = Ix / (h / 2).
    public var sectionModulusX: SectionModulus { secondMomentOfAreaX / (height / 2) }
    /// Elastic modulus about y using the outer fiber, Sy = Iy / (b / 2).
    public var sectionModulusY: SectionModulus { secondMomentOfAreaY / (width / 2) }
}
