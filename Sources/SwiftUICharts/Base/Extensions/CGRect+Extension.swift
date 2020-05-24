//
//  CGRect+Extension.swift
//  SwiftUICharts
//
//  Created by Nicolas Savoini on 2020-05-24.
//

import Foundation
import SwiftUI

extension CGRect {
    // Return the coordinate for a rectangle center
    public var mid: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}
