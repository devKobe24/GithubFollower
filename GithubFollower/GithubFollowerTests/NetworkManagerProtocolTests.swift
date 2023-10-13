//
//  NetworkManagerProtocolTests.swift
//  GithubFollowerTests
//
//  Created by Minseong Kang on 2023/10/08.
//

import XCTest
@testable import GithubFollower

final class NetworkManagerProtocolTests: XCTestCase {
    var sut: NetworkManagerProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkManagerProtocol()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // MARK: - reset
    func test_URL요청으로_MaryJo_github이라는값을받아올때() {
        // given
        let promiseLogin = XCTestExpectation(description: "MaryJo-github")
        let expectation = XCTestExpectation(description: "MaryJo-github")
        
        let url = URL(string: "https://api.github.com/users/devKobe24/followers?per_page=1&page=1")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let followerLoginData = "MaryJo-github".data(using: .utf8)
        let dummyData = DummyData(data: followerLoginData, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummayData: dummyData)
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.getFollower(
            for: "devKobe24",
            perPage: 1,
            page: 1) { (followers, errorMessage) in
                // then
                guard let followerLogin = followers?[0].login else { return }
                let followerLoginData = XCTestExpectation(description: followerLogin)
                XCTAssertEqual(followerLoginData, expectation)
            }
    }
}
