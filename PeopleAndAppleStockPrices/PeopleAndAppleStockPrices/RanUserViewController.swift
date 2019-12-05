//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class RanUserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userArr = [Users]() {
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
        userArr = UserData.getUsers().sorted { $0.name["last"]! < $1.name["last"]! }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let userVC = segue.destination as? RanUserDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        userVC.user = userArr[indexPath.row]
    }
    
    
}

extension RanUserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        
        let user = userArr[indexPath.row]
        
        var city = user.location.city
        var state = user.location.state
        
        guard var firstName = user.name["first"], var lastName = user.name["last"], let capOne = firstName.first?.uppercased(), let capTwo = lastName.first?.uppercased(), let cityCap = user.location.city.first?.uppercased(), let stateCap = user.location.state.first?.uppercased() else {
            fatalError()
        }
        firstName.removeFirst()
        firstName = capOne + firstName
        lastName.removeFirst()
        lastName = capTwo + lastName
        
        
        city.removeFirst()
        city = cityCap + city
        state.removeFirst()
        state = stateCap + state
        
        cell.textLabel?.text = "\(lastName), \(firstName)"
        cell.detailTextLabel?.text = "\(city), \(state)"
        
        
        return cell
    }
    
    
}

