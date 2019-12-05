//
//  AppleStockDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kelby Mittan on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class AppleStockDetailController: UIViewController {

    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    var stock: AppleStockData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        guard let validStock = stock else { fatalError("could not load stock")
        }
        
        openLabel.text = validStock.open.description
        closeLabel.text = validStock.close.description
        
        if validStock.open < validStock.close {
            view.backgroundColor = .green
            stockImage.image = UIImage(named: "thumbsUp")
        } else {
            view.backgroundColor = .red
            stockImage.image = UIImage(named: "thumbsDown")
        }
    }
    

}


//A UIImage
//A label to represent the date
//Two labels to represent the opening and closing prices
//If the stock price went up that day, set the background color to green and make the image a thumbs up.
//
//If the stock price went down that day, set the background color to red and make the image a thumbs down.
//
//You will need to use Auto Layout to constrain your views.
