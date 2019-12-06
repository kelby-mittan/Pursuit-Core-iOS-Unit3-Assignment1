//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Kelby Mittan on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest

@testable import PeopleAndAppleStockPrices

class PeopleAndAppleStockPricesTests: XCTestCase {

    let filename = "userinfo"
    let ext = "json"
    

    func testReadingDataFromRandomUsersFile() {
        // act (when)
        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        
        // assert (then)
        XCTAssertNotNil(data)
    }
    
    func testLocation() {
        let firstLocation = getUsers().first
        let expectedCity = "cardiff"
        let city = firstLocation?.location.city ?? "not loading"
        
        XCTAssertEqual(expectedCity, city, "city should be \(expectedCity)")
    }


}

extension PeopleAndAppleStockPricesTests {
    
    func getUsers() -> [Users] {
        let users = UserData.getUsers()
        return users
    }
    
}
