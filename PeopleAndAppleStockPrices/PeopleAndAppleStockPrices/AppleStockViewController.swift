//
//  AppleStockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kelby Mittan on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class AppleStockViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stockArr = [[AppleStockData]]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        stockArr = AppleStockData.getStockSections()
    }
    
    func getAvg(for arr: [AppleStockData]) -> Double {
        var sum = 0.0
        var avg = Double()
        for stock in arr {
            sum += stock.open
        }
        
        avg = sum / Double(arr.count)
        return avg
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockVC = segue.destination as? AppleStockDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        stockVC.stock = stockArr[indexPath.section][indexPath.row]
    }
    
    
}

extension AppleStockViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockArr[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        
        let stock = stockArr[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = "\(stock.date)"
        cell.detailTextLabel?.text = "\(stock.open.description)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let avg = getAvg(for: stockArr[section])
        let month = stockArr[section].first?.label.components(separatedBy: " ").first ?? ""
        let year = stockArr[section].first?.label.components(separatedBy: " ").last ?? ""
        return "\(month) - 20\(year), average open: \(String(format: "%.2f", avg))"
    }
    
    
}
