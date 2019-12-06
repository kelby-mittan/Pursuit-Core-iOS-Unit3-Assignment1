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
    let date: String
}

extension AppleStockData {
    // parse the "topStoriesTechnology.json" into an array of [NewsHeadline] objects
    static func getStocks() -> [AppleStockData] {
        
        var stock = [AppleStockData]()
        guard let file = Bundle.main.url(forResource: "applestockinfo", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        do {
            let data = try Data(contentsOf: file)
            
            let stockData = try JSONDecoder().decode([AppleStockData].self, from: data)
            stock = stockData
            
        } catch {
            fatalError("contents failed to load \(error)")
        }
        
        return stock
    }
    
    static func getStockSections() -> [[AppleStockData]] {
        let stocks = getStocks()
        var monthTTitles = Set<String>()
        
        for stock in stocks {
            var label = stock.label
            var monthYear = label.components(separatedBy: " ")
            monthYear.remove(at: 1)
            label = monthYear.joined()
            monthTTitles.insert(label)
        }
        
        var sectionsArr = Array(repeating: [AppleStockData](), count: monthTTitles.count)
        
        var currentIndex = 0
        var currentMonth = stocks.first?.label.components(separatedBy: " ").first ?? ""
        for stock in stocks {
            let month = stock.label.components(separatedBy: " ").first ?? ""
    
            if month == currentMonth {
                sectionsArr[currentIndex].append(stock)
            } else {
                currentIndex += 1
                currentMonth = stock.label.components(separatedBy: " ").first ?? ""
                sectionsArr[currentIndex].append(stock)
            }
        }
        return sectionsArr
    }
}
