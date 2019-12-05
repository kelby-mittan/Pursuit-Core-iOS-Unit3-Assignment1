//
//  Users.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kelby Mittan on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    let results: [Users]
}

struct Users: Decodable {
    let name: Name
    let email: String
    let location: Location
    let phone: String
    let dob: String
    let picture: Picture
    
}

struct Picture: Decodable {
    let large: String
    
    private enum CodingKeys: String, CodingKey {
        case large = "large"
    }
}

struct Name: Decodable {
    let title: String
    let firstName: String
    let lastName: String
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    var fullNameReversed: String {
        "\(lastName) \(firstName)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case firstName = "first"
        case lastName = "last"
    }
}

struct Location: Decodable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}


extension UserData {
    static func getUsers() -> [Users] {
        
        var userArr = [Users]()
        
        
        guard let file = Bundle.main.url(forResource: "userinfo", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        
        do {
            let data = try Data(contentsOf: file)
                        
            let userData = try JSONDecoder().decode(UserData.self, from: data)
            
            userArr = userData.results
        } catch {
            fatalError("contents failed to load \(error)")
        }
        
        return userArr
    }
}
