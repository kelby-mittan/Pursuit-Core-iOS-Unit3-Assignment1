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
        
        addressLabel.text = """
        \(validUser.name.lastName.capitalized), \(validUser.name.firstName.capitalized)
        
        \(validUser.location.street.capitalized)
        \(validUser.location.city.capitalized), \(validUser.location.state.capitalized) \(validUser.location.postcode.capitalized)
        """
        

        guard let date = getDateFromString(dateString: validUser.dob) else {
            return
        }

        dobLabel.text = "DOB: \(dateFormatter.string(from: date))"
        phoneLabel.text = "Phone: \(validUser.phone)"
        
        ImageClient.fetchImage(for: validUser.picture.large) { [weak self] (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.contactImage.image = image
                    }
                    
                case .failure(let error):
                    print("error \(error)")
                }
            }
        
    }
    
}
