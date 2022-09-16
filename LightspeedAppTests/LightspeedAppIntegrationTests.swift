//
//  LightspeedAppIntegrationTests.swift
//  LightspeedAppTests
//
//  Created by Ilana Haddad on 2022-09-16.
//

import XCTest
@testable import LightspeedApp

class LightspeedAppIntegrationTests: XCTestCase {

    func testAPIRequest() {
        let apiManager = APIManager()
        var response: [PictureData]?
        let expectation = self.expectation(description: "Response Time under 60 seconds")
        
        apiManager.fetchPictureDataFromAPI(completionHandler: { pictures in
            response = pictures
            expectation.fulfill()
        })
        waitForExpectations(timeout: 60, handler: nil)
        XCTAssertNotNil(response?[0])
    }

}
