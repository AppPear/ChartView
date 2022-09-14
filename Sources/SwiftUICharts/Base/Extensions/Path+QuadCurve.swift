import SwiftUI

extension Path {
    func trimmedPath(for percent: CGFloat) -> Path {
        let boundsDistance: CGFloat = 0.001
        let completion: CGFloat = 1 - boundsDistance
        
        let pct = percent > 1 ? 0 : (percent < 0 ? 1 : percent)

        // Start/end points centered around given percentage, but capped if right at the very end
        let start = pct > completion ? completion : pct - boundsDistance
        let end = pct > completion ? 1 : pct + boundsDistance
        return trimmedPath(from: start, to: end)
    }

    func point(for percent: CGFloat) -> CGPoint {
        let path = trimmedPath(for: percent)
        return CGPoint(x: path.boundingRect.midX, y: path.boundingRect.midY)
    }

    func point(to maxX: CGFloat) -> CGPoint {
        let total = length
        let sub = length(to: maxX)
        let percent = sub / total
        return point(for: percent)
    }

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

    static func quadCurvedPathWithPoints(data: [(Double, Double)], in rect: CGRect) -> Path {
        var path = Path()
        if data.count < 2 {
            return path
        }

        let convertedXValues = data.map { CGFloat($0.0) * rect.width }
        let convertedYPoints = data.map { CGFloat($0.1) * rect.height }

        var point1 = CGPoint(x: convertedXValues[0], y: convertedYPoints[0])
        path.move(to: point1)
        for pointIndex in 1..<data.count {
            let point2 = CGPoint(x: CGFloat(convertedXValues[pointIndex]), y: CGFloat(convertedYPoints[pointIndex]))
            let midPoint = CGPoint.midPointForPoints(firstPoint: point1, secondPoint: point2)
            path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(firstPoint: midPoint, secondPoint: point1))
            path.addQuadCurve(to: point2, control: CGPoint.controlPointForPoints(firstPoint: midPoint, secondPoint: point2))
            point1 = point2
        }
        return path
    }

    static func drawChartMarkers(data: [(Double, Double)], in rect: CGRect) -> Path {
        var path = Path()
        if data.count < 1 {
            return path
        }

        let convertedXValues = data.map { CGFloat($0.0) * rect.width }
        let convertedYPoints = data.map { CGFloat($0.1) * rect.height }

        let markerSize = CGSize(width: 8, height: 8)
        for pointIndex in 0..<data.count {
            path.addRoundedRect(in: CGRect(origin: CGPoint(x: convertedXValues[pointIndex] - markerSize.width / 2,
                                                           y: convertedYPoints[pointIndex] - markerSize.height / 2),
                                           size: markerSize),
                                cornerSize: CGSize(width: markerSize.width / 2,
                                                   height: markerSize.height / 2))
        }
        return path
    }

    static func drawGridLines(numberOfHorizontalLines: Int, numberOfVerticalLines: Int, in rect: CGRect) -> Path {
        var path = Path()

        for index in 0..<numberOfHorizontalLines {
            let normalisedSpacing = 1.0 / CGFloat(numberOfHorizontalLines - 1)
            let startPoint = CGPoint(x: 0, y: normalisedSpacing * CGFloat(index) * rect.height)
            let endPoint = CGPoint(x: rect.width, y: normalisedSpacing * CGFloat(index) * rect.height)
            path.move(to: startPoint)
            path.addLine(to: endPoint)
        }

        for index in 0..<numberOfVerticalLines {
            let normalisedSpacing = 1.0 / CGFloat(numberOfVerticalLines - 1)
            let startPoint = CGPoint(x: normalisedSpacing * CGFloat(index) * rect.width, y: 0)
            let endPoint = CGPoint(x: normalisedSpacing * CGFloat(index) * rect.width, y: rect.height)
            path.move(to: startPoint)
            path.addLine(to: endPoint)
        }

        return path
    }

    static func quadClosedCurvedPathWithPoints(data: [(Double, Double)], in rect: CGRect) -> Path {
        var path = Path()
        if data.count < 2 {
            return path
        }

        let convertedXValues = data.map { CGFloat($0.0) * rect.width }
        let convertedYPoints = data.map { CGFloat($0.1) * rect.height }

        path.move(to: .zero)
        var point1 = CGPoint(x: convertedXValues[0], y: convertedYPoints[0])
        path.addLine(to: point1)
        for pointIndex in 1..<data.count {
            let point2 = CGPoint(x: CGFloat(convertedXValues[pointIndex]), y: CGFloat(convertedYPoints[pointIndex]))
            let midPoint = CGPoint.midPointForPoints(firstPoint: point1, secondPoint: point2)
            path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(firstPoint: midPoint, secondPoint: point1))
            path.addQuadCurve(to: point2, control: CGPoint.controlPointForPoints(firstPoint: midPoint, secondPoint: point2))
            point1 = point2
        }
        path.addLine(to: CGPoint(x: point1.x, y: 0))
        path.closeSubpath()
        return path
    }

    static func linePathWithPoints(data: [(Double, Double)], in rect: CGRect) -> Path {
        var path = Path()
        if data.count < 2 {
            return path
        }

        let convertedXValues = data.map { CGFloat($0.0) * rect.width }
        let convertedYPoints = data.map { CGFloat($0.1) * rect.height }

        let point1 = CGPoint(x: convertedXValues[0], y: convertedYPoints[0])
        path.move(to: point1)
        for pointIndex in 1..<data.count {
            let point2 = CGPoint(x: CGFloat(convertedXValues[pointIndex]), y: CGFloat(convertedYPoints[pointIndex]))
            path.addLine(to: point2)
        }
        return path
    }

    static func closedLinePathWithPoints(data: [(Double, Double)], in rect: CGRect) -> Path {
        var path = Path()
        if data.count < 2 {
            return path
        }

        let convertedXValues = data.map { CGFloat($0.0) * rect.width }
        let convertedYPoints = data.map { CGFloat($0.1) * rect.height }
        path.move(to: .zero)

        let point1 = CGPoint(x: convertedXValues[0], y: convertedYPoints[0])
        path.addLine(to: point1)

        for pointIndex in 1..<data.count {
            let point2 = CGPoint(x: CGFloat(convertedXValues[pointIndex]), y: CGFloat(convertedYPoints[pointIndex]))
            path.addLine(to: point2)
        }
        path.addLine(to: CGPoint(x: point1.x, y: 0))
        path.closeSubpath()

        return path
    }
    
}

extension CGPoint {
    func point(to: CGPoint, x: CGFloat) -> CGPoint {
        let a = (to.y - self.y) / (to.x - self.x)
        let y = self.y + (x - self.x) * a
        return CGPoint(x: x, y: y)
    }

    func line(to: CGPoint) -> CGFloat {
        dist(to: to)
    }

    func line(to: CGPoint, x: CGFloat) -> CGFloat {
        dist(to: point(to: to, x: x))
    }

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

    func point(to: CGPoint, t: CGFloat, control: CGPoint) -> CGPoint {
        let x = CGPoint.value(x: self.x, y: to.x, t: t, c: control.x)
        let y = CGPoint.value(x: self.y, y: to.y, t: t, c: control.y)
        
        return CGPoint(x: x, y: y)
    }

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

    func point(to: CGPoint, t: CGFloat, control1: CGPoint, control2: CGPoint) -> CGPoint {
        let x = CGPoint.value(x: self.x, y: to.x, t: t, control1: control1.x, control2: control2.x)
        let y = CGPoint.value(x: self.y, y: to.y, t: t, control1: control1.y, control2: control2.x)
        
        return CGPoint(x: x, y: y)
    }

    static func value(x: CGFloat, y: CGFloat, t: CGFloat, c: CGFloat) -> CGFloat {
        var value: CGFloat = 0.0
        // (1-t)^2 * p0 + 2 * (1-t) * t * c1 + t^2 * p1
        value += pow(1-t, 2) * x
        value += 2 * (1-t) * t * c
        value += pow(t, 2) * y
        return value
    }

    static func value(x: CGFloat, y: CGFloat, t: CGFloat, control1: CGFloat, control2: CGFloat) -> CGFloat {
        var value: CGFloat = 0.0
        // (1-t)^3 * p0 + 3 * (1-t)^2 * t * c1 + 3 * (1-t) * t^2 * c2 + t^3 * p1
        value += pow(1-t, 3) * x
        value += 3 * pow(1-t, 2) * t * control1
        value += 3 * (1-t) * pow(t, 2) * control2
        value += pow(t, 3) * y
        return value
    }

    static func getMidPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(
            x: point1.x + (point2.x - point1.x) / 2,
            y: point1.y + (point2.y - point1.y) / 2
        )
    }

    func dist(to: CGPoint) -> CGFloat {
        return sqrt((pow(self.x - to.x, 2) + pow(self.y - to.y, 2)))
    }

    static func midPointForPoints(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
        return CGPoint(
            x: (firstPoint.x + secondPoint.x) / 2,
            y: (firstPoint.y + secondPoint.y) / 2)
    }

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
