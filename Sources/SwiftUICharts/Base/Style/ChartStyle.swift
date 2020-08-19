import SwiftUI

/// Descripton of colors/styles for any kind of chart
public class ChartStyle: ObservableObject {

	/// colors for background are of chart
	public let backgroundColor: ColorGradient
	/// colors for foreground fill of chart
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
