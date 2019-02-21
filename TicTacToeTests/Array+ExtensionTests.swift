//
//  Array+ExtensionTests
//
//  Created by 2019_DEV_108

import XCTest
@testable import TicTacToe

class ArrayExtensionTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
 
    func testHorizontalLines() {
        let array = [0,0,0,
                     1,1,1,
                     0,0,0
                     ]
        testResultFor(array: array, startingAtIndex: 0, searchStep: 1, expectedResult: 0)
        testResultFor(array: array, startingAtIndex: 3, searchStep: 1, expectedResult: 1)
        testResultFor(array: array, startingAtIndex: 6, searchStep: 1, expectedResult: 0)
    }
    func testVerticalLines() {
        let array = [0,1,0,
                     0,1,0,
                     0,1,0
        ]
        testResultFor(array: array, startingAtIndex: 0, searchStep: 3, expectedResult: 0)
        testResultFor(array: array, startingAtIndex: 1, searchStep: 3, expectedResult: 1)
        testResultFor(array: array, startingAtIndex: 2, searchStep: 3, expectedResult: 0)
    }
    func testDiagonalLines() {
        var array = [1,0,0,
                     0,1,0,
                     0,0,1
        ]
        testResultFor(array: array, startingAtIndex: 0, searchStep: 4, expectedResult: 1)
        array = [0,0,1,
                 0,1,0,
                 1,0,1
        ]
        testResultFor(array: array, startingAtIndex: 2, searchStep: 2, expectedResult: 1)
    }
    
    private func testResultFor(array: [Int], startingAtIndex: Int, searchStep: Int, expectedResult: Int) {
        do {
            guard let result = try array.findConsecutiveValues(startingAtIndex: startingAtIndex, searchStep: searchStep, limit: 3) else {
                XCTFail("result should be \(expectedResult)")
                return
            }
            XCTAssert(result == expectedResult)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
 

}
