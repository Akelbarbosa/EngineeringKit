//
//  RectangularSection.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

/// A solid rectangular cross-section with width along x and height along y.
///
/// The local origin is the lower-left corner. Second moments and elastic section
/// moduli use the horizontal x and vertical y axes through the centroid.
public struct RectangularSection: Sendable, Equatable {
    /// The positive horizontal dimension b, measured along x.
    public let width: Length

    /// The positive vertical dimension h, measured along y.
    public let height: Length

    /// Creates a solid rectangle from positive, finite dimensions in any units.
    ///
    /// - Throws: SectionGeometryError.invalidDimension for the invalid dimension.
    public init(width: Length, height: Length) throws {
        let widthInMeters = width.value(in: .meter)
        let heightInMeters = height.value(in: .meter)
        guard widthInMeters.isFinite && widthInMeters > 0 else {
            throw SectionGeometryError.invalidDimension(name: "width")
        }
        guard heightInMeters.isFinite && heightInMeters > 0 else {
            throw SectionGeometryError.invalidDimension(name: "height")
        }
        self.width = width
        self.height = height
    }

    /// Cross-sectional area A = b × h.
    public var area: Area {
        width * height
    }

    /// Horizontal centroid coordinate b / 2, measured from the left edge.
    public var centroidX: Length {
        width / 2
    }

    /// Vertical centroid coordinate h / 2, measured from the bottom edge.
    public var centroidY: Length {
        height / 2
    }

    /// Centroidal second moment about the horizontal x-axis, Ix = b × h³ / 12.
    public var secondMomentOfAreaX: SecondMomentOfArea {
        let b = width.value(in: .meter)
        let h = height.value(in: .meter)
        return SecondMomentOfArea(value: b * h * h * h / 12, unit: .meterToFourthPower)
    }

    /// Centroidal second moment about the vertical y-axis, Iy = h × b³ / 12.
    public var secondMomentOfAreaY: SecondMomentOfArea {
        let b = width.value(in: .meter)
        let h = height.value(in: .meter)
        return SecondMomentOfArea(value: h * b * b * b / 12, unit: .meterToFourthPower)
    }

    /// Elastic section modulus about x, Sx = Ix / (h / 2).
    public var sectionModulusX: SectionModulus {
        secondMomentOfAreaX / (height / 2)
    }

    /// Elastic section modulus about y, Sy = Iy / (b / 2).
    public var sectionModulusY: SectionModulus {
        secondMomentOfAreaY / (width / 2)
    }
}
