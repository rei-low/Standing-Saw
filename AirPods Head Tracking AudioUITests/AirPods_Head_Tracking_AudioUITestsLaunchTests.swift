//
//  AirPods_Head_Tracking_AudioUITestsLaunchTests.swift
//  AirPods Head Tracking AudioUITests
//
//  Created by Braxton Clark on 10/12/26.
//

import XCTest

final class AirPods_Head_Tracking_AudioUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
