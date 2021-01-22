//
//  MuslimAssisstantAssessmentTests.swift
//  MuslimAssisstantAssessmentTests
//
//  Created by Abo-Aljoud94 on 1/20/21.
//

import XCTest
@testable import MuslimAssisstantAssessment

class MuslimAssisstantAssessmentTests: XCTestCase {
    
    let APIManager = MockAPIManger(false)
    
    func testGetCountries() {
        let exception = self.expectation(description: "getCountries Exception")
        
        APIManager.shouldReturnError = false
        APIManager.getCountries { (res) in
            
            switch res {
                case .success(let json):
                    XCTAssertNotNil(json)
                    exception.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }

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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
