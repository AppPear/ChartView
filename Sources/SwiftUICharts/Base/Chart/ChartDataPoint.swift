//
//  File.swift
//  
//
//  Created by Carlton Jester on 1/5/22.
//

import Foundation

public protocol ChartDataPoint: Equatable {
    var chartPoint: Double { get }
    var chartValue: String { get }
}
