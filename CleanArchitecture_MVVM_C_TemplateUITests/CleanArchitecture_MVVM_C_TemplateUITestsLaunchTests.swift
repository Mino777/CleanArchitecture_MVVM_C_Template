//
//  CleanArchitecture_MVVM_C_TemplateUITestsLaunchTests.swift
//  CleanArchitecture_MVVM_C_TemplateUITests
//
//  Created by 조민호 on 2021/12/08.
//

import XCTest

class CleanArchitecture_MVVM_C_TemplateUITestsLaunchTests: XCTestCase {

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
