import Foundation
import XCTest

final class DocumentationIntegrityTests: XCTestCase {

    func testExampleFileExists() {
        let examplePath = repositoryRoot.appendingPathComponent("example.md").path
        XCTAssertTrue(FileManager.default.fileExists(atPath: examplePath))
    }

    func testReadmeLinksToExampleFile() throws {
        let readme = try String(contentsOf: repositoryRoot.appendingPathComponent("README.md"), encoding: .utf8)
        XCTAssertTrue(readme.contains("./example.md"))
    }

    func testReferencedReadmeResourcesExist() throws {
        let readme = try String(contentsOf: repositoryRoot.appendingPathComponent("README.md"), encoding: .utf8)
        let referencedResources = extractResourcePaths(from: readme)

        XCTAssertFalse(referencedResources.isEmpty)

        for resourcePath in referencedResources {
            let fullPath = repositoryRoot.appendingPathComponent(resourcePath).path
            XCTAssertTrue(FileManager.default.fileExists(atPath: fullPath), "Missing resource: \(resourcePath)")
        }
    }

    private var repositoryRoot: URL {
        URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }

    private func extractResourcePaths(from content: String) -> Set<String> {
        guard let regex = try? NSRegularExpression(pattern: #"Resources/[A-Za-z0-9_.-]+"#) else {
            return []
        }

        let matches = regex.matches(in: content, range: NSRange(content.startIndex..., in: content))

        return Set(matches.compactMap { match in
            guard let range = Range(match.range, in: content) else {
                return nil
            }
            return String(content[range])
        })
    }
}
