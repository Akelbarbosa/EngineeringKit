//
//  GeometryView.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import SwiftUI
import EngineeringKit

/// A minimal consumer view using quantities and geometry without exposing raw units.
struct GeometryView: View {
    /// Presents a calculated moment and a physically validated rectangular section.
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("EngineeringKit").font(.title)
            Text("Moment: \((2.knewton * 500.millimeter).value(in: .kilonewtonMeter)) kN·m")
            // Real applications should surface geometry validation errors to the user.
            if let section = try? RectangularSection(width: 2.inch, height: 6.inch) {
                Text("Area: \(section.area.value(in: .squareInch)) in²")
                Text("Ix: \(section.secondMomentOfAreaX.value(in: .inchToFourthPower)) in⁴")
                Text("kx: \(section.radiusOfGyrationX.value(in: .inch)) in")
            } else {
                Text("Invalid section dimensions")
            }
        }
        .padding()
    }
}
