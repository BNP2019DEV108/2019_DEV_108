//
//  Array+Extension.swift
//  TicTacToe
//
//  Created 2019_DEV_108 
//

import Foundation
extension Array where Element == Int {
    enum SearchError: Error {
        case outOfRange(Int), parameter(String)
    }
    
    // searches for the same consecutive value in an array, starting from an index, using a step and constreined by a limit
    func findConsecutiveValues(startingAtIndex index: Int, searchStep: Int, limit: Int) throws -> Int? {
        guard index >= 0, index < count else {
            throw SearchError.outOfRange(index)
        }
        guard searchStep > 0, searchStep < count else {
            throw SearchError.parameter("searchStep not within bounds")
        }
        guard limit > 0, limit < count else {
            throw SearchError.parameter("limit not within bounds")
        }
        let winningValue = self[index]
        //        print("index \(index)    searchStep \(searchStep)")
        //        print("winningValue \(winningValue)")
        
        var i = 1
        repeat {
            let currentIndex = index + (i * searchStep)
            guard currentIndex < count else {
                throw SearchError.outOfRange(i)
            }
            let currentValue = self[currentIndex]
            //            print("currentIndex \(currentIndex)     currentValue \(currentValue)")
            guard currentValue == winningValue else {
                return nil
            }
            //            print("currentValue == winningValue")
            i += 1
        } while i < limit
        //        print("winningValue == \(winningValue)")
        return winningValue
    }
}

