//
//  RanUserDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kelby Mittan on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class RanUserDetailController: UIViewController {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var user: Users?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy" //"EEEE, MMM d, yyyy h:mm a"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactImage.layer.cornerRadius = 10
        updateUI()
        
    }
    
    func getDateFromString(dateString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
           formatter.formatOptions = [.withDashSeparatorInDate,
                                      .withFullDate,
                                      .withColonSeparatorInTimeZone]
           guard let date = formatter.date(from: dateString) else {
             return nil
           }
           return date
    }
    
    func updateUI() {
        
        guard let validUser = user else {
            fatalError("could not load user")
        }
        
        guard var firstName = validUser.name["first"], var lastName = validUser.name["last"], let capOne = firstName.first?.uppercased(), let capTwo = lastName.first?.uppercased() else {
            fatalError()
        }
        firstName.removeFirst()
        firstName = capOne + firstName
        lastName.removeFirst()
        lastName = capTwo + lastName
        
        
        
        
        addressLabel.text = """
        \(lastName), \(firstName)
        
        \(validUser.location.street)
        \(validUser.location.city), \(validUser.location.state) \(validUser.location.postcode)
        """
        

        guard let date = getDateFromString(dateString: validUser.dob) else {
            return
        }

        dobLabel.text = "DOB: \(dateFormatter.string(from: date))"
        
        phoneLabel.text = "Phone: \(validUser.phone)"
        
    }
    
}
