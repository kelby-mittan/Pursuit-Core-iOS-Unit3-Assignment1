//
//  Users.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kelby Mittan on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserData: Codable {
    let results: [Users]
}

struct Users: Codable {
    let name: Name
    let email: String
    let location: Location
    let phone: String
    let dob: String
    
}

struct Name: Codable {
    let title: String
    let firstName: String
    let lastName: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case firstName = "first"
        case lastName = "last"
    }
}

struct Location: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}


enum Postcode: Codable {
    func encode(to encoder: Encoder) throws {
        return
    }
    case int(Int), string(String)

    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }

        throw QuantumError.missingValue
    }

    enum QuantumError:Error {
        case missingValue
    }
    
    func extractValue() -> String {
        var result = ""
        switch self {
        case .int(let value):
            result = value.description
        case .string(let valueStr):
            result = valueStr
        }
        return result
    }
}

extension UserData {
    static func getUsers() -> [Users] {
        
        var userArr = [Users]()
        
        
        guard let fileURL = Bundle.main.url(forResource: "userinfo", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        
        
        do {
            let data = try Data(contentsOf: fileURL)
                        
            let userData = try JSONDecoder().decode(UserData.self, from: data)
            
            userArr = userData.results
        } catch {
            fatalError("contents failed to load \(error)")
        }
        
        return userArr
    }
}
