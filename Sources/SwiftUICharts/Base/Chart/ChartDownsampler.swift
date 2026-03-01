import Foundation

enum ChartDownsampler {
    static func reduced(_ data: [(Double, Double)], maxPoints: Int) -> [(Double, Double)] {
        let limit = max(2, maxPoints)
        guard data.count > limit else { return data }

        let stride = Double(data.count - 1) / Double(limit - 1)
        var reduced: [(Double, Double)] = []
        reduced.reserveCapacity(limit)

        for index in 0..<limit {
            let sourceIndex = Int(round(Double(index) * stride))
            let clampedIndex = max(0, min(data.count - 1, sourceIndex))
            reduced.append(data[clampedIndex])
        }

        return reduced
    }
}
