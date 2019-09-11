//
//  Line.swift
//  LineChart
//
//  Created by András Samu on 2019. 08. 30..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct Line: View {
    @ObservedObject var data: ChartData
    @Binding var frame: CGRect
    @Binding var touchLocation: CGPoint
    @Binding var showIndicator: Bool
    @State private var showFull: Bool = false
    @State var showBackground: Bool = true
    
    var stepWidth: CGFloat {
        return frame.size.width / CGFloat(data.points.count-1)
    }
    var stepHeight: CGFloat {
        return frame.size.height / CGFloat(data.points.max()! + data.points.min()!)
    }
    var path: Path {
        return Path.quadCurvedPathWithPoints(points: data.points, step: CGPoint(x: stepWidth, y: stepHeight))
    }
    var closedPath: Path {
        return Path.quadClosedCurvedPathWithPoints(points: data.points, step: CGPoint(x: stepWidth, y: stepHeight))
    }
    
    var body: some View {
        ZStack {
            if(self.showFull && self.showBackground){
                self.closedPath
                    .fill(LinearGradient(gradient: Gradient(colors: [Colors.GradientUpperBlue, .white]), startPoint: .bottom, endPoint: .top))
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .transition(.opacity)
                    .animation(.easeIn(duration: 1.6))
            }
            self.path
                .trim(from: 0, to: self.showFull ? 1:0)
                .stroke(LinearGradient(gradient: Gradient(colors: [Colors.GradientPurple, Colors.GradientNeonBlue]), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: 3))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .animation(.easeOut(duration: 1.2))
                .onAppear(){
                    self.showFull.toggle()
            }.drawingGroup()
            if(self.showIndicator) {
                IndicatorPoint()
                    .position(self.getClosestPointOnPath(touchLocation: self.touchLocation))
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
    }
    
    func getClosestPointOnPath(touchLocation: CGPoint) -> CGPoint {
        let percentage:CGFloat = min(max(touchLocation.x,0)/self.frame.width,1)
        let closest = self.path.percentPoint(percentage)
        return closest
    }
    
}

extension CGPoint {
    static func getMidPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
      return CGPoint(
        x: point1.x + (point2.x - point1.x) / 2,
        y: point1.y + (point2.y - point1.y) / 2
      )
    }
    
    func dist(to: CGPoint) -> CGFloat {
      return sqrt((pow(self.x - to.x, 2) + pow(self.y - to.y, 2)))
    }
    
    static func midPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
        return CGPoint(x:(p1.x + p2.x) / 2,y: (p1.y + p2.y) / 2)
    }

    static func controlPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
        var controlPoint = CGPoint.midPointForPoints(p1:p1, p2:p2)
        let diffY = abs(p2.y - controlPoint.y)

        if (p1.y < p2.y){
            controlPoint.y += diffY
        } else if (p1.y > p2.y) {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
}
extension Path {
    static func quadCurvedPathWithPoints(points:[Int], step:CGPoint) -> Path {
        var path = Path()
        var p1 = CGPoint(x: 0, y: CGFloat(points[0])*step.y)
        path.move(to: p1)
        if(points.count < 2){
            path.addLine(to: CGPoint(x: step.x, y: step.y*CGFloat(points[1])))
            return path
        }
        for pointIndex in 1..<points.count {
            let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]))
            let midPoint = CGPoint.midPointForPoints(p1: p1, p2: p2)
            path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p1))
            path.addQuadCurve(to: p2, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p2))
            p1 = p2
        }
        return path
    }
    
    static func quadClosedCurvedPathWithPoints(points:[Int], step:CGPoint) -> Path {
        var path = Path()
        path.move(to: .zero)
        var p1 = CGPoint(x: 0, y: CGFloat(points[0])*step.y)
        path.addLine(to: p1)
        if(points.count < 2){
            path.addLine(to: CGPoint(x: step.x, y: step.y*CGFloat(points[1])))
            return path
        }
        for pointIndex in 1..<points.count {
            let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y*CGFloat(points[pointIndex]))
            let midPoint = CGPoint.midPointForPoints(p1: p1, p2: p2)
            path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p1))
            path.addQuadCurve(to: p2, control: CGPoint.controlPointForPoints(p1: midPoint, p2: p2))
            p1 = p2
        }
        path.addLine(to: CGPoint(x: p1.x, y: 0))
        path.closeSubpath()
        return path
    }
    
    func percentPoint(_ percent: CGFloat) -> CGPoint {
        // percent difference between points
        let diff: CGFloat = 0.001
        let comp: CGFloat = 1 - diff
        
        // handle limits
        let pct = percent > 1 ? 0 : (percent < 0 ? 1 : percent)
        
        let f = pct > comp ? comp : pct
        let t = pct > comp ? 1 : pct + diff
        let tp = self.trimmedPath(from: f, to: t)
        
        return CGPoint(x: tp.boundingRect.midX, y: tp.boundingRect.midY)
    }
    
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            Line(data: TestData.data, frame: .constant(geometry.frame(in: .local)), touchLocation: .constant(CGPoint(x: 300, y: 12)), showIndicator: .constant(true))
        }.frame(width: 320, height: 160)
    }
}
