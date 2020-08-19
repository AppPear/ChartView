import SwiftUI

extension Path {

	/// Returns a tiny segment of path based on percentage along the path
	///
	/// TODO: Explain why more than 1 gets 0 and why less than 0 gets 1
	/// - Parameter percent: fraction along data set, between 0.0 and 1.0 (underflow and overflow are handled)
	/// - Returns: tiny path right around the requested fraction
    func trimmedPath(for percent: CGFloat) -> Path {
        let boundsDistance: CGFloat = 0.001
        let completion: CGFloat = 1 - boundsDistance
        
        let pct = percent > 1 ? 0 : (percent < 0 ? 1 : percent)

		// Start/end points centered around given percentage, but capped if right at the very end
        let start = pct > completion ? completion : pct - boundsDistance
        let end = pct > completion ? 1 : pct + boundsDistance
        return trimmedPath(from: start, to: end)
    }

	/// Find the `CGPoint` for the given fraction along the path.
	///
	/// This works by requesting a very tiny trimmed section of the path, then getting the center of the bounds rectangle
	/// - Parameter percent: fraction along data set, between 0.0 and 1.0 (underflow and overflow are handled)
	/// - Returns: a `CGPoint` representing the location of that section of the path
    func point(for percent: CGFloat) -> CGPoint {
        let path = trimmedPath(for: percent)
        return CGPoint(x: path.boundingRect.midX, y: path.boundingRect.midY)
    }

	/// <#Description#>
	/// - Parameter maxX: <#maxX description#>
	/// - Returns: <#description#>
    func point(to maxX: CGFloat) -> CGPoint {
        let total = length
        let sub = length(to: maxX)
        let percent = sub / total
        return point(for: percent)
    }
    
	/// <#Description#>
	/// - Returns: <#description#>
   var length: CGFloat {
        var ret: CGFloat = 0.0
        var start: CGPoint?
        var point = CGPoint.zero
        
        forEach { ele in
            switch ele {
            case .move(let to):
                if start == nil {
                    start = to
                }
                point = to
            case .line(let to):
                ret += point.line(to: to)
                point = to
            case .quadCurve(let to, let control):
                ret += point.quadCurve(to: to, control: control)
                point = to
            case .curve(let to, let control1, let control2):
                ret += point.curve(to: to, control1: control1, control2: control2)
                point = to
            case .closeSubpath:
                if let to = start {
                    ret += point.line(to: to)
                    point = to
                }
                start = nil
            }
        }
        return ret
    }

	/// <#Description#>
	/// - Parameter maxX: <#maxX description#>
	/// - Returns: <#description#>
    func length(to maxX: CGFloat) -> CGFloat {
        var ret: CGFloat = 0.0
        var start: CGPoint?
        var point = CGPoint.zero
        var finished = false
        
        forEach { ele in
            if finished {
                return
            }
            switch ele {
            case .move(let to):
                if to.x > maxX {
                    finished = true
                    return
                }
                if start == nil {
                    start = to
                }
                point = to
            case .line(let to):
                if to.x > maxX {
                    finished = true
                    ret += point.line(to: to, x: maxX)
                    return
                }
                ret += point.line(to: to)
                point = to
            case .quadCurve(let to, let control):
                if to.x > maxX {
                    finished = true
                    ret += point.quadCurve(to: to, control: control, x: maxX)
                    return
                }
                ret += point.quadCurve(to: to, control: control)
                point = to
            case .curve(let to, let control1, let control2):
                if to.x > maxX {
                    finished = true
                    ret += point.curve(to: to, control1: control1, control2: control2, x: maxX)
                    return
                }
                ret += point.curve(to: to, control1: control1, control2: control2)
                point = to
            case .closeSubpath:
                fatalError("Can't include closeSubpath")
            }
        }
        return ret
    }

	/// <#Description#>
	/// - Parameters:
	///   - points: <#points description#>
	///   - step: <#step description#>
	///   - globalOffset: <#globalOffset description#>
	/// - Returns: <#description#>
    static func quadCurvedPathWithPoints(points: [Double], step: CGPoint, globalOffset: Double? = nil) -> Path {
        var path = Path()
        if points.count < 2 {
            return path
        }
        let offset = globalOffset ?? points.min()!
//        guard let offset = points.min() else { return path }
        var point1 = CGPoint(x: 0, y: CGFloat(points[0]-offset)*step.y)
        path.move(to: point1)
        for pointIndex in 1..<points.count {
            let point2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]-offset))
            let midPoint = CGPoint.midPointForPoints(firstPoint: point1, secondPoint: point2)
            path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(firstPoint: midPoint, secondPoint: point1))
            path.addQuadCurve(to: point2, control: CGPoint.controlPointForPoints(firstPoint: midPoint, secondPoint: point2))
            point1 = point2
        }
        return path
    }

	/// <#Description#>
	/// - Parameters:
	///   - points: <#points description#>
	///   - step: <#step description#>
	///   - globalOffset: <#globalOffset description#>
	/// - Returns: <#description#>
    static func quadClosedCurvedPathWithPoints(points: [Double], step: CGPoint, globalOffset: Double? = nil) -> Path {
        var path = Path()
        if points.count < 2 {
            return path
        }
        let offset = globalOffset ?? points.min()!

//        guard let offset = points.min() else { return path }
        path.move(to: .zero)
        var point1 = CGPoint(x: 0, y: CGFloat(points[0]-offset)*step.y)
        path.addLine(to: point1)
        for pointIndex in 1..<points.count {
            let point2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]-offset))
            let midPoint = CGPoint.midPointForPoints(firstPoint: point1, secondPoint: point2)
            path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(firstPoint: midPoint, secondPoint: point1))
            path.addQuadCurve(to: point2, control: CGPoint.controlPointForPoints(firstPoint: midPoint, secondPoint: point2))
            point1 = point2
        }
        path.addLine(to: CGPoint(x: point1.x, y: 0))
        path.closeSubpath()
        return path
    }

	/// <#Description#>
	/// - Parameters:
	///   - points: <#points description#>
	///   - step: <#step description#>
	/// - Returns: <#description#>
    static func linePathWithPoints(points: [Double], step: CGPoint) -> Path {
        var path = Path()
        if points.count < 2 {
            return path
        }
        guard let offset = points.min() else {
            return path
        }
        let point1 = CGPoint(x: 0, y: CGFloat(points[0]-offset)*step.y)
        path.move(to: point1)
        for pointIndex in 1..<points.count {
            let point2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]-offset))
            path.addLine(to: point2)
        }
        return path
    }

	/// <#Description#>
	/// - Parameters:
	///   - points: <#points description#>
	///   - step: <#step description#>
	/// - Returns: <#description#>
    static func closedLinePathWithPoints(points: [Double], step: CGPoint) -> Path {
        var path = Path()
        if points.count < 2 {
            return path
        }
        guard let offset = points.min() else {
            return path
        }
        var point1 = CGPoint(x: 0, y: CGFloat(points[0]-offset)*step.y)
        path.move(to: point1)
        for pointIndex in 1..<points.count {
            point1 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]-offset))
            path.addLine(to: point1)
        }
        path.addLine(to: CGPoint(x: point1.x, y: 0))
        path.closeSubpath()
        return path
    }
    
}

extension CGPoint {

	/// <#Description#>
	/// - Parameters:
	///   - to: <#to description#>
	///   - x: <#x description#>
	/// - Returns: <#description#>
    func point(to: CGPoint, x: CGFloat) -> CGPoint {
        let a = (to.y - self.y) / (to.x - self.x)
        let y = self.y + (x - self.x) * a
        return CGPoint(x: x, y: y)
    }

	/// <#Description#>
	/// - Parameter to: <#to description#>
	/// - Returns: <#description#>
    func line(to: CGPoint) -> CGFloat {
        dist(to: to)
    }

	/// <#Description#>
	/// - Parameters:
	///   - to: <#to description#>
	///   - x: <#x description#>
	/// - Returns: <#description#>
    func line(to: CGPoint, x: CGFloat) -> CGFloat {
        dist(to: point(to: to, x: x))
    }

	/// <#Description#>
	/// - Parameters:
	///   - to: <#to description#>
	///   - control: <#control description#>
	/// - Returns: <#description#>
    func quadCurve(to: CGPoint, control: CGPoint) -> CGFloat {
        var dist: CGFloat = 0
        let steps: CGFloat = 100
        
        for i in 0..<Int(steps) {
            let t0 = CGFloat(i) / steps
            let t1 = CGFloat(i+1) / steps
            let a = point(to: to, t: t0, control: control)
            let b = point(to: to, t: t1, control: control)
            
            dist += a.line(to: b)
        }
        return dist
    }

	/// <#Description#>
	/// - Parameters:
	///   - to: <#to description#>
	///   - control: <#control description#>
	///   - x: <#x description#>
	/// - Returns: <#description#>
    func quadCurve(to: CGPoint, control: CGPoint, x: CGFloat) -> CGFloat {
        var dist: CGFloat = 0
        let steps: CGFloat = 100
        
        for i in 0..<Int(steps) {
            let t0 = CGFloat(i) / steps
            let t1 = CGFloat(i+1) / steps
            let a = point(to: to, t: t0, control: control)
            let b = point(to: to, t: t1, control: control)
            
            if a.x >= x {
                return dist
            } else if b.x > x {
                dist += a.line(to: b, x: x)
                return dist
            } else if b.x == x {
                dist += a.line(to: b)
                return dist
            }
            
            dist += a.line(to: b)
        }
        return dist
    }

	/// <#Description#>
	/// - Parameters:
	///   - to: <#to description#>
	///   - t: <#t description#>
	///   - control: <#control description#>
	/// - Returns: <#description#>
    func point(to: CGPoint, t: CGFloat, control: CGPoint) -> CGPoint {
        let x = CGPoint.value(x: self.x, y: to.x, t: t, c: control.x)
        let y = CGPoint.value(x: self.y, y: to.y, t: t, c: control.y)
        
        return CGPoint(x: x, y: y)
    }

	/// <#Description#>
	/// - Parameters:
	///   - to: <#to description#>
	///   - control1: <#control1 description#>
	///   - control2: <#control2 description#>
	/// - Returns: <#description#>
    func curve(to: CGPoint, control1: CGPoint, control2: CGPoint) -> CGFloat {
        var dist: CGFloat = 0
        let steps: CGFloat = 100
        
        for i in 0..<Int(steps) {
            let t0 = CGFloat(i) / steps
            let t1 = CGFloat(i+1) / steps
            
            let a = point(to: to, t: t0, control1: control1, control2: control2)
            let b = point(to: to, t: t1, control1: control1, control2: control2)
            
            dist += a.line(to: b)
        }
        
        return dist
    }

	/// <#Description#>
	/// - Parameters:
	///   - to: <#to description#>
	///   - control1: <#control1 description#>
	///   - control2: <#control2 description#>
	///   - x: <#x description#>
	/// - Returns: <#description#>
    func curve(to: CGPoint, control1: CGPoint, control2: CGPoint, x: CGFloat) -> CGFloat {
        var dist: CGFloat = 0
        let steps: CGFloat = 100
        
        for i in 0..<Int(steps) {
            let t0 = CGFloat(i) / steps
            let t1 = CGFloat(i+1) / steps
            
            let a = point(to: to, t: t0, control1: control1, control2: control2)
            let b = point(to: to, t: t1, control1: control1, control2: control2)
            
            if a.x >= x {
                return dist
            } else if b.x > x {
                dist += a.line(to: b, x: x)
                return dist
            } else if b.x == x {
                dist += a.line(to: b)
                return dist
            }
            
            dist += a.line(to: b)
        }
        
        return dist
    }

	/// <#Description#>
	/// - Parameters:
	///   - to: <#to description#>
	///   - t: <#t description#>
	///   - control1: <#control1 description#>
	///   - control2: <#control2 description#>
	/// - Returns: <#description#>
    func point(to: CGPoint, t: CGFloat, control1: CGPoint, control2: CGPoint) -> CGPoint {
        let x = CGPoint.value(x: self.x, y: to.x, t: t, control1: control1.x, control2: control2.x)
        let y = CGPoint.value(x: self.y, y: to.y, t: t, control1: control1.y, control2: control2.x)
        
        return CGPoint(x: x, y: y)
    }

	/// <#Description#>
	/// - Parameters:
	///   - x: <#x description#>
	///   - y: <#y description#>
	///   - t: <#t description#>
	///   - c: <#c description#>
	/// - Returns: <#description#>
    static func value(x: CGFloat, y: CGFloat, t: CGFloat, c: CGFloat) -> CGFloat {
        var value: CGFloat = 0.0
        // (1-t)^2 * p0 + 2 * (1-t) * t * c1 + t^2 * p1
        value += pow(1-t, 2) * x
        value += 2 * (1-t) * t * c
        value += pow(t, 2) * y
        return value
    }

	/// <#Description#>
	/// - Parameters:
	///   - x: <#x description#>
	///   - y: <#y description#>
	///   - t: <#t description#>
	///   - control1: <#control1 description#>
	///   - control2: <#control2 description#>
	/// - Returns: <#description#>
    static func value(x: CGFloat, y: CGFloat, t: CGFloat, control1: CGFloat, control2: CGFloat) -> CGFloat {
        var value: CGFloat = 0.0
        // (1-t)^3 * p0 + 3 * (1-t)^2 * t * c1 + 3 * (1-t) * t^2 * c2 + t^3 * p1
        value += pow(1-t, 3) * x
        value += 3 * pow(1-t, 2) * t * control1
        value += 3 * (1-t) * pow(t, 2) * control2
        value += pow(t, 3) * y
        return value
    }

	/// <#Description#>
	/// - Parameters:
	///   - point1: <#point1 description#>
	///   - point2: <#point2 description#>
	/// - Returns: <#description#>
    static func getMidPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(
            x: point1.x + (point2.x - point1.x) / 2,
            y: point1.y + (point2.y - point1.y) / 2
        )
    }

	/// <#Description#>
	/// - Parameter to: <#to description#>
	/// - Returns: <#description#>
    func dist(to: CGPoint) -> CGFloat {
        return sqrt((pow(self.x - to.x, 2) + pow(self.y - to.y, 2)))
    }

	/// <#Description#>
	/// - Parameters:
	///   - firstPoint: <#firstPoint description#>
	///   - secondPoint: <#secondPoint description#>
	/// - Returns: <#description#>
    static func midPointForPoints(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
        return CGPoint(
            x: (firstPoint.x + secondPoint.x) / 2,
            y: (firstPoint.y + secondPoint.y) / 2)
    }

	/// <#Description#>
	/// - Parameters:
	///   - firstPoint: <#firstPoint description#>
	///   - secondPoint: <#secondPoint description#>
	/// - Returns: <#description#>
    static func controlPointForPoints(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
        var controlPoint = CGPoint.midPointForPoints(firstPoint: firstPoint, secondPoint: secondPoint)
        let diffY = abs(secondPoint.y - controlPoint.y)
        
        if firstPoint.y < secondPoint.y {
            controlPoint.y += diffY
        } else if firstPoint.y > secondPoint.y {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
}
