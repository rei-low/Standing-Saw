//
//  AirPods_Head_Tracking_AudioUITests.swift
//  AirPods Head Tracking AudioUITests
//
//  Created by Braxton Clark on 10/12/26.
//

import XCTest

final class AirPods_Head_Tracking_AudioUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
