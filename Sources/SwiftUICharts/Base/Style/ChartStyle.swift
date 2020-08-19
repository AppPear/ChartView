import SwiftUI

/// <#Description#>
public class ChartStyle: ObservableObject {

	/// <#Description#>
	public let backgroundColor: ColorGradient
	/// <#Description#>
    public let foregroundColor: [ColorGradient]

	/// <#Description#>
	/// - Parameters:
	///   - backgroundColor: <#backgroundColor description#>
	///   - foregroundColor: <#foregroundColor description#>
    public init(backgroundColor: Color, foregroundColor: [ColorGradient]) {
        self.backgroundColor = ColorGradient.init(backgroundColor)
        self.foregroundColor = foregroundColor
    }

	/// <#Description#>
	/// - Parameters:
	///   - backgroundColor: <#backgroundColor description#>
	///   - foregroundColor: <#foregroundColor description#>
    public init(backgroundColor: Color, foregroundColor: ColorGradient) {
        self.backgroundColor = ColorGradient.init(backgroundColor)
        self.foregroundColor = [foregroundColor]
    }

	/// <#Description#>
	/// - Parameters:
	///   - backgroundColor: <#backgroundColor description#>
	///   - foregroundColor: <#foregroundColor description#>
    public init(backgroundColor: ColorGradient, foregroundColor: ColorGradient) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = [foregroundColor]
    }

	/// <#Description#>
	/// - Parameters:
	///   - backgroundColor: <#backgroundColor description#>
	///   - foregroundColor: <#foregroundColor description#>
    public init(backgroundColor: ColorGradient, foregroundColor: [ColorGradient]) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
}
