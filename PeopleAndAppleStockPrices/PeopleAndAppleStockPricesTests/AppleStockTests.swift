//
//  AppleStockTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Kelby Mittan on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest

@testable import PeopleAndAppleStockPrices

class AppleStockTests: XCTestCase {

    let filename = "applestockinfo"
    let ext = "json"
    

    func testReadingDataFromRandomUsersFile() {

        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        
        XCTAssertNotNil(data)
    }
    
    func testFirstStockOpen() {
        let firstOpen = getStocks().first
        let expectedOpen = 164.6
        
        let open = firstOpen?.open ?? 1.0
        
        XCTAssertEqual(expectedOpen, open, "open should be \(expectedOpen.description)")
    }
    
    func testFirstDateLabel() {
        let firstDateLabel = getStocks().first
        let expectedLabel = "Aug 29, 17"
        
        let label = firstDateLabel?.label ?? "could not load"
        XCTAssertEqual(expectedLabel, label, "label should be \(expectedLabel)")
    }

}

extension AppleStockTests {
    
    func getRawData() -> Data {
        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        return data
    }
    
    func getStocks() -> [AppleStockData] {
//        let data = getRawData()
        let stocks = AppleStockData.getStocks()
        return stocks
    }
    
}
