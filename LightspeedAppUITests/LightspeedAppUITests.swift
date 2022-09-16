//
//  LightspeedAppUITests.swift
//  LightspeedAppUITests
//
//  Created by Ilana Haddad on 2022-09-12.
//

import XCTest
@testable import LightspeedApp

class LightspeedAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testVCHasTableView() {
        app.launch()
        
        let tableView = app.tables["pictureTableView"]
        XCTAssertTrue(tableView.exists, "The table view exists")
    }
    
    func testTableViewHasZeroCellsAtLaunch() {
        app.launch()
        
        let tableView = app.tables["pictureTableView"]
        XCTAssertTrue(tableView.cells.count == 0)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
