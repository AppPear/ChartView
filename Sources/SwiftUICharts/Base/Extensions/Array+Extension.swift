import Foundation

extension Array where Element == ColorGradient {
	
	/// <#Description#>
	/// - Parameter index: <#index description#>
	/// - Returns: <#description#>
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
