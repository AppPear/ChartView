//
//  File.swift
//  
//
//  Created by 曾文志 on 2020/7/30.
//

import SwiftUI

func isPointInCircle(point: CGPoint, circleRect: CGRect) -> Bool {
    let r = min(circleRect.width, circleRect.height) / 2
    let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
    let dx = point.x - center.x
    let dy = point.y - center.y
    let distance = sqrt(dx * dx + dy * dy)
    return distance <= r
}

func degree(for point: CGPoint, inCircleRect circleRect: CGRect) -> Double {
    let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
    let dx = point.x - center.x
    let dy = point.y - center.y
    let acuteDegree = Double(atan(dy / dx)) * (180 / .pi)
    
    let isInBottomRight = dx >= 0 && dy >= 0
    let isInBottomLeft = dx <= 0 && dy >= 0
    let isInTopLeft = dx <= 0 && dy <= 0
    let isInTopRight = dx >= 0 && dy <= 0
    
    if isInBottomRight {
        return acuteDegree
    } else if isInBottomLeft {
        return 180 - abs(acuteDegree)
    } else if isInTopLeft {
        return 180 + abs(acuteDegree)
    } else if isInTopRight {
        return 360 - abs(acuteDegree)
    }
    
    return 0
}
