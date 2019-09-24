import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AppIcon_ResizerTests.allTests),
    ]
}
#endif
