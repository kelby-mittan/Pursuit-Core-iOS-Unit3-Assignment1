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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var userArr = [Users]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchQuery = "" {
        didSet {
            userArr = UserData.getUsers().filter { $0.name.fullName.lowercased().contains(searchQuery.lowercased()) || $0.name.fullNameReversed.lowercased().contains(searchQuery.lowercased()) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        userArr = UserData.getUsers().sorted { $0.name.lastName < $1.name.lastName }
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
        
        cell.textLabel?.text = "\(user.name.lastName.capitalized), \(user.name.firstName.capitalized)"
        cell.detailTextLabel?.text = "\(user.location.city.capitalized), \(user.location.state.capitalized)"
        
        return cell
    }
    
    
}

extension RanUserViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            return
        }
        searchQuery = searchText

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        
        searchQuery = searchText
        
    }
    
    
}

