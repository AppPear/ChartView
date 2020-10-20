//
//  MagnifierRect.swift
//  
//
//  Created by Samu András on 2020. 03. 04..
//

import SwiftUI

public struct MagnifierRect: View {
    @Binding var currentNumber: Double
    @Binding var currentXValue: CustomStringConvertible?
    var valueSpecifier:String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var body: some View {
        VStack{
            Text("\(self.currentNumber, specifier: valueSpecifier)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                .padding(16)
            Spacer()
            if let currentValue = currentXValue {
                Text(String(describing: currentValue))
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .foregroundColor(self.colorScheme == .dark ? Color.white : Color.gray)
                    .padding(16)
            }
        }
        .background(colorScheme == .dark ?
            AnyView(RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: self.colorScheme == .dark ? 2 : 0))
            :
            AnyView(RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color.white)
                .shadow(color: Colors.LegendText, radius: 12, x: 0, y: 6 )
                .blendMode(.multiply))
        )
    }
}
