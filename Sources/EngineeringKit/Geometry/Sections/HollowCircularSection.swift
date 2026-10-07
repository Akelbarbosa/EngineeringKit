//
//  HollowCircularSection.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// A concentric circular tube, excluding the inner circular opening.
///
/// The origin is the lower-left corner of the outer bounding square. All
/// second moments and elastic moduli use axes through the common center.
public struct HollowCircularSection: PlaneSection, Equatable {
    /// Diameter of the outer circular boundary.
    public let outerDiameter: Length
    /// Positive diameter of the concentric opening.
    public let innerDiameter: Length

    /// Creates a tube from positive, finite diameters with inner < outer.
    /// - Throws: SectionGeometryError for an invalid dimension or relationship.
    public init(outerDiameter: Length, innerDiameter: Length) throws {
        let outer = outerDiameter.value(in: .meter)
        let inner = innerDiameter.value(in: .meter)
        guard outer.isFinite && outer > 0 else {
            throw SectionGeometryError.invalidDimension(name: "outerDiameter")
        }
        guard inner.isFinite && inner > 0 else {
            throw SectionGeometryError.invalidDimension(name: "innerDiameter")
        }
        guard inner < outer else {
            throw SectionGeometryError.invalidDiameterRelationship
        }
        self.outerDiameter = outerDiameter
        self.innerDiameter = innerDiameter
    }

    /// Uniform radial wall thickness (outerDiameter - innerDiameter) / 2.
    public var wallThickness: Length { (outerDiameter - innerDiameter) / 2 }

    /// Area A = π(D² - d²) / 4, factored to limit thin-wall cancellation.
    public var area: Area {
        let outer = outerDiameter.value(in: .meter)
        let inner = innerDiameter.value(in: .meter)
        return Area(value: Double.pi * (outer - inner) * (outer + inner) / 4,
                    unit: .squareMeter)
    }

    /// Horizontal centroid coordinate D / 2.
    public var centroidX: Length { outerDiameter / 2 }
    /// Vertical centroid coordinate D / 2.
    public var centroidY: Length { outerDiameter / 2 }

    /// Centroidal horizontal moment Ix = π(D⁴ - d⁴) / 64.
    public var secondMomentOfAreaX: SecondMomentOfArea {
        let outer = outerDiameter.value(in: .meter)
        let inner = innerDiameter.value(in: .meter)
        return SecondMomentOfArea(
            value: area.value(in: .squareMeter) * (outer * outer + inner * inner) / 16,
            unit: .meterToFourthPower)
    }

    /// Centroidal vertical moment, equal to Ix by circular symmetry.
    public var secondMomentOfAreaY: SecondMomentOfArea { secondMomentOfAreaX }
    /// Elastic section modulus using the outermost fiber, Sx = Ix / (D / 2).
    public var sectionModulusX: SectionModulus { secondMomentOfAreaX / (outerDiameter / 2) }
    /// Elastic section modulus using the outermost fiber, Sy = Iy / (D / 2).
    public var sectionModulusY: SectionModulus { sectionModulusX }
}
