//
//  LabelView.swift
//  BarChart
//
//  Created by Samu András on 2020. 01. 08..
//  Copyright © 2020. Samu András. All rights reserved.
//

import SwiftUI

struct LabelView: View {
    @Binding var arrowOffset: CGFloat
    @Binding var title:String
    var body: some View {
        VStack{
            ArrowUp().fill(Color.white).frame(width: 20, height: 12, alignment: .center).shadow(color: Color.gray, radius: 8, x: 0, y: 0).offset(x: getArrowOffset(offset:self.arrowOffset), y: 12)
            ZStack{
                RoundedRectangle(cornerRadius: 8).frame(width: 100, height: 32, alignment: .center).foregroundColor(Color.white).shadow(radius: 8)
                Text(self.title).font(.caption).bold()
                ArrowUp().fill(Color.white).frame(width: 20, height: 12, alignment: .center).zIndex(999).offset(x: getArrowOffset(offset:self.arrowOffset), y: -20)

            }
        }
    }
    
    func getArrowOffset(offset: CGFloat) -> CGFloat {
        return max(-36,min(36, offset))
    }
}

struct ArrowUp: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width/2, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(arrowOffset: .constant(0), title: .constant("Tesla model 3"))
    }
}
