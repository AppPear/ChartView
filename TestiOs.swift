//
//  TestiOs.swift
//  SwiftUICharts
//
//  Created by Nicolas Savoini on 2020-05-31.
//

import SwiftUI

struct TestiOs: View {

    @State var conf = ChartTypeConfiguration(data: [1, 2, 3, 4, 5])
    
    var body: some View {
        
        VStack {
            
            CardView {
                ChartView(data: self.$conf)
            }
            
            CardView {
                ChartView(data: self.$conf)
                .type(LineChart())
            }
            
            CardView {
                ChartView(data: self.$conf)
                .type(PieChart())
            }
            
            Button(action: {
                self.conf.data[0] = Double.random(in: 0 ..< 10)
                self.conf.data[1] = Double.random(in: 0 ..< 10)
                self.conf.data[2] = Double.random(in: 0 ..< 10)
                self.conf.data[3] = Double.random(in: 0 ..< 10)
                self.conf.data[4] = Double.random(in: 0 ..< 10)
            }) {
                Text("Click to Update")
            }
            
        }
        
        
    }
}

struct TestiOs_Previews: PreviewProvider {
    static var previews: some View {
        TestiOs()
    }
}
