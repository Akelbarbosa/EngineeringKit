//
//  PlaneSection.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// Typed properties of a plane cross-section about orthogonal centroidal axes.
///
/// Conforming types document their local origin and provide positive physical
/// dimensions. x is horizontal and y is vertical. These are geometric area
/// properties, not mass moments or material-dependent stiffnesses.
public protocol PlaneSection: Sendable {
    /// Cross-sectional area.
    var area: Area { get }
    /// Horizontal centroid coordinate relative to the shape's local origin.
    var centroidX: Length { get }
    /// Vertical centroid coordinate relative to the shape's local origin.
    var centroidY: Length { get }
    /// Second moment of area about the horizontal centroidal x-axis.
    var secondMomentOfAreaX: SecondMomentOfArea { get }
    /// Second moment of area about the vertical centroidal y-axis.
    var secondMomentOfAreaY: SecondMomentOfArea { get }
    /// Elastic section modulus about the centroidal x-axis.
    var sectionModulusX: SectionModulus { get }
    /// Elastic section modulus about the centroidal y-axis.
    var sectionModulusY: SectionModulus { get }
}

public extension PlaneSection {
    /// Polar second moment about the centroid, J = Ix + Iy.
    ///
    /// This is not the Saint-Venant torsion constant for a general section.
    var polarMomentOfArea: SecondMomentOfArea {
        secondMomentOfAreaX + secondMomentOfAreaY
    }

    /// Area radius of gyration about x, kx = sqrt(Ix / A).
    var radiusOfGyrationX: Length {
        Length(value: (secondMomentOfAreaX.value(in: .meterToFourthPower)
            / area.value(in: .squareMeter)).squareRoot(), unit: .meter)
    }

    /// Area radius of gyration about y, ky = sqrt(Iy / A).
    var radiusOfGyrationY: Length {
        Length(value: (secondMomentOfAreaY.value(in: .meterToFourthPower)
            / area.value(in: .squareMeter)).squareRoot(), unit: .meter)
    }

    /// Moment about an axis parallel to x, offset vertically from the centroid.
    ///
    /// Uses Ix + A × offsetY². Zero and negative offsets are valid; the offset
    /// is a distance from the centroidal axis, not a local y-coordinate.
    /// - Throws: SectionGeometryError.nonFiniteOffset for NaN or infinity.
    func secondMomentOfAreaX(offsetY: Length) throws -> SecondMomentOfArea {
        let offset = offsetY.value(in: .meter)
        guard offset.isFinite else {
            throw SectionGeometryError.nonFiniteOffset(name: "offsetY")
        }
        return secondMomentOfAreaX + SecondMomentOfArea(
            value: area.value(in: .squareMeter) * offset * offset,
            unit: .meterToFourthPower)
    }

    /// Moment about an axis parallel to y, offset horizontally from the centroid.
    ///
    /// Uses Iy + A × offsetX². Zero and negative offsets are valid; the offset
    /// is a distance from the centroidal axis, not a local x-coordinate.
    /// - Throws: SectionGeometryError.nonFiniteOffset for NaN or infinity.
    func secondMomentOfAreaY(offsetX: Length) throws -> SecondMomentOfArea {
        let offset = offsetX.value(in: .meter)
        guard offset.isFinite else {
            throw SectionGeometryError.nonFiniteOffset(name: "offsetX")
        }
        return secondMomentOfAreaY + SecondMomentOfArea(
            value: area.value(in: .squareMeter) * offset * offset,
            unit: .meterToFourthPower)
    }
}
