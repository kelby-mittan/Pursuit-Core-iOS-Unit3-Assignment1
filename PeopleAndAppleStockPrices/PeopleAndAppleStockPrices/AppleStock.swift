//
//  AppleStock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kelby Mittan on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AppleStockData: Codable {
    let open: Double
    let close: Double
    let label: String
    
}

extension AppleStockData {
    // parse the "topStoriesTechnology.json" into an array of [NewsHeadline] objects
    static func getStocks() -> [AppleStockData] {
        
        var stock = [AppleStockData]()
        
        
        guard let fileURL = Bundle.main.url(forResource: "applestockinfo", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        
        
        do {
            let data = try Data(contentsOf: fileURL)
                        
            let stockData = try JSONDecoder().decode([AppleStockData].self, from: data)
            stock = stockData
            
        } catch {
            fatalError("contents failed to load \(error)")
        }
        
        return stock
    }
}
