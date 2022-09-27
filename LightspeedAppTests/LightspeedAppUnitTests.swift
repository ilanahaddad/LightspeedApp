//
//  LightspeedAppTests.swift
//  LightspeedAppTests
//
//  Created by Ilana Haddad on 2022-09-12.
//

import XCTest
@testable import LightspeedApp

class LightspeedAppUnitTests: XCTestCase {
    let apiManager = APIManager()
    
    func testMakingRequest() throws {
        let urlRequest = try apiManager.makeRequest(from: "https://picsum.photos/v2/list")
        XCTAssertTrue(urlRequest.url?.scheme == "https")
        XCTAssertTrue(urlRequest.url?.path == "/v2/list")
        XCTAssertTrue(urlRequest.url?.host == "picsum.photos")
    }
    
    func testParsingResponse() throws {
        let jsonData = "[{\"id\":\"0\",\"author\":\"Author\",\"width\":5616,\"height\":3744,\"url\":\"https://unsplash.com/photos/yC-Yzbqy7PY\",\"download_url\":\"https://picsum.photos/id/0/5616/3744\"}]".data(using: .utf8)!
        let response = try apiManager.parseResponse(data: jsonData)
        XCTAssertTrue(response.count == 1)
        XCTAssertTrue(response[0].author == "Author")
    }
    
    func testNoImages() throws {
        let allPictures = [FinalPicture]()
        let randomPic = APIManager().fetchRandomImage(allPictures: allPictures)
        XCTAssertNil(randomPic)
    }
    
    func testRandomImage() throws {
        let picture1 = FinalPicture(author: "author1", image: UIImage())
        let picture2 = FinalPicture(author: "author2", image: UIImage())
        let picture3 = FinalPicture(author: "author3", image: UIImage())
        let picture4 = FinalPicture(author: "author4", image: UIImage())
        let pictures = [picture1, picture2, picture3, picture4]
        let randomPic = APIManager().fetchRandomImage(allPictures: pictures)
        XCTAssertNotNil(randomPic)
    }
}
