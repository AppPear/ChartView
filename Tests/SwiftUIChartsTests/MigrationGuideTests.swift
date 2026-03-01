import Foundation
import XCTest

final class MigrationGuideTests: XCTestCase {

    func testMigrationGuideExists() {
        let migrationPath = repositoryRoot.appendingPathComponent("MIGRATION.md").path
        XCTAssertTrue(FileManager.default.fileExists(atPath: migrationPath))
    }

    func testMigrationGuideCoversRemovedPublicTypes() throws {
        let migration = try String(contentsOf: repositoryRoot.appendingPathComponent("MIGRATION.md"), encoding: .utf8)

        let requiredSymbols = [
            "LineChartView",
            "BarChartView",
            "PieChartView",
            "MultiLineChartView",
            "LineView",
            "GradientColor",
            "GradientColors",
            "Colors",
            "Styles",
            "ChartForm",
            "MultiLineChartData",
            "MagnifierRect",
            "TestData"
        ]

        for symbol in requiredSymbols {
            XCTAssertTrue(migration.contains(symbol), "Missing migration mapping for \(symbol)")
        }
    }

    private var repositoryRoot: URL {
        URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }
}
