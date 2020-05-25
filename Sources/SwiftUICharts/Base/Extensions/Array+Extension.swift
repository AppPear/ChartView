//
//  File.swift
//  
//
//  Created by Nicolas Savoini on 2020-05-25.
//

import Foundation

extension Array where Element == ColorGradient {
    func rotate(for index: Int) -> ColorGradient {
        if self.isEmpty {
            return ColorGradient.orangeBright
        }
        
        if self.count <= index {
            return self[index % self.count]
        }
        
        return self[index]
    }
}
