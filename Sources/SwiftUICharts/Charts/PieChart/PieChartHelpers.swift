import SwiftUI

func isPointInCircle(point: CGPoint, circleRect: CGRect) -> Bool {
    let circleRect = circleRect.sanitized
    let r = min(circleRect.width, circleRect.height) / 2
    guard r > 0 else { return false }
    let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
    let dx = point.x - center.x
    let dy = point.y - center.y
    let distance = sqrt(dx * dx + dy * dy)
    return distance <= r
}

func degree(for point: CGPoint, inCircleRect circleRect: CGRect) -> Double {
    let circleRect = circleRect.sanitized
    let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
    let dx = point.x - center.x
    let dy = point.y - center.y
    guard dx != 0 else {
        return dy >= 0 ? 90 : 270
    }
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
