//
//  Accedo_iOS_Developer_Test_Project_tvOSUITestsLaunchTests.swift
//  Accedo iOS Developer Test Project tvOSUITests
//
//  Created by Abu Umair Jihan on 2022-04-03.
//

import XCTest

class Accedo_iOS_Developer_Test_Project_tvOSUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
