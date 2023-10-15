//
//  GFNetworkTests.swift
//  GFNetworkTests
//
//  Created by Minseong Kang on 2023/10/13.
//

import XCTest
@testable import GithubFollower

final class GFNetworkTests: XCTestCase {
    var sut: NetworkManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func test_올바른아이디를_URL에_요청시_데이터가_들어오는지() {
        // given
        let url = URL(string: "https://api.github.com/users/devKobe24/followers?per_page=1&page=1")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // when
        sut.urlSession.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            let decoder = JSONDecodeProtocol()
            
            do {
                guard let followersData = try decoder.decodeJSON(type: [Follower].self, data: data).first else { return }
                // then
                XCTAssertNotNil(followersData)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func test_돌아오는_첫번째_login_데이터가_expectation과_같은_값을_내어주는지() {
        // given
        let url = URL(string: "https://api.github.com/users/devKobe24/followers?per_page=1&page=1")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // when
        sut.urlSession.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            let decoder = JSONDecodeProtocol()
            
            do {
                guard let followersData = try decoder.decodeJSON(type: [Follower].self, data: data).first else { return }
                let followerLoginData = XCTestExpectation(description: followersData.login)
                let expectation = XCTestExpectation(description: "MaryJo-github")
                // then
                XCTAssertEqual(followerLoginData, expectation)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func test_URL_요청시_상태코드_200번이_들어오는지() {
        // given
        let expectation = 200
        let url = URL(string: "https://api.github.com/users/devKobe24/followers?per_page=1&page=1")!
        
        // when
        sut.urlSession.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            let statusCode = response.statusCode
            
            // then
            XCTAssertEqual(statusCode, expectation)
            
        }.resume()
    }
    
    func test_URL_요청시_에러가_nil이_들어오는지() {
        // given
        let url = URL(string: "https://api.github.com/users/devKobe24/followers?per_page=1&page=1")!
        // when
        sut.urlSession.dataTask(with: url) { (data, response, error) in
            // then
            XCTAssertNil(error)
        }.resume()
    }
}
