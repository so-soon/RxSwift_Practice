//
//  RxFlickrSearchTests.swift
//  RxFlickrSearchTests
//
//  Created by Randy on 2021/03/11.
//

import XCTest
import RxBlocking

@testable import RxFlickrSearch

class RxFlickrSearchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAPIService(){
        do{
            let data = try APIService.shared.photoSearch(with: "tennis").toBlocking().first()
            print(data)
            XCTAssertNotNil(data)
        }catch(let error){
            print(error.localizedDescription)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
