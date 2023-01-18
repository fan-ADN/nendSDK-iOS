//
//  BannerAdDelegationTests.swift
//  BannerUITests
//
//  Copyright © 2022 FAN Communications. All rights reserved.
//

import XCTest

class BannerAdDelegationTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.

        let app = XCUIApplication()
        app.launch()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Banner"].tap()
        tablesQuery.staticTexts["320x50"].tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOnlyLoad() throws {
        let app = XCUIApplication()

        waitingSec(sec: 3.0, sender: self)

        XCTAssertTrue(app.staticTexts["labelDidReceiveAd"].label.contains("2"))
        XCTAssertTrue(app.staticTexts["labelDidFinishLoad"].label.contains("2"))
        XCTAssertFalse(app.staticTexts["labelDidFailToReceiveAd"].label.contains("2"))
        XCTAssertFalse(app.staticTexts["labelDidClickAd"].label.contains("2"))
        XCTAssertFalse(app.staticTexts["labelDidClickInformation"].label.contains("2"))
    }

    func testClickAd() throws {
        let app = XCUIApplication()

        waitingSec(sec: 3.0, sender: self)

        app.otherElements["NADView"].tap()
        backFromSafari(sender: self, customUrlScheme: "swiftexample://openapp")

        XCTAssertTrue(app.staticTexts["labelDidReceiveAd"].label.contains("2"))
        XCTAssertTrue(app.staticTexts["labelDidFinishLoad"].label.contains("2"))
        XCTAssertTrue(app.staticTexts["labelDidClickAd"].label.contains("1"))
        XCTAssertFalse(app.staticTexts["labelDidFailToReceiveAd"].label.contains("1"))
        XCTAssertFalse(app.staticTexts["labelDidClickInformation"].label.contains("1"))
    }

    private func waitingSec(sec: Double, sender: XCTestCase) {
        weak var expectation = sender.expectation(description: "Waiting")
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            expectation?.fulfill()
        }
        sender.waitForExpectations(timeout: TimeInterval(sec + 2)) { _ in
            // do nothing
        }
    }

    private func backFromSafari(sender: XCTestCase, customUrlScheme: String) {
        XCUIDevice.shared.orientation = .portrait
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        safari.activate()
        waitingSec(sec: 3.0, sender: sender)

        if safari.buttons["URL"].exists {
            safari.buttons["URL"].tap()
        } else if safari.otherElements["URL"].exists {
            safari.otherElements["URL"].tap()
        }

        if #available(iOS 15.0, *) {
            if UIDevice.current.userInterfaceIdiom == .phone {
                safari.otherElements["CapsuleNavigationBar?isSelected=true"].tap()
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                safari.buttons["UnifiedTabBarItemView?isSelected=true"].tap()
            }
            safari.typeText(customUrlScheme)
        } else {
            let addressBar = safari.textFields["URL"]
            addressBar.typeText(customUrlScheme)
        }
        safari.buttons["Go"].tap()

        waitingSec(sec: 1.0, sender: sender)

        if safari.buttons["開く"].exists {
            safari.buttons["開く"].tap()
        } else {
            safari.buttons["Open"].tap()
        }
        waitingSec(sec: 3.0, sender: sender)
    }
}
