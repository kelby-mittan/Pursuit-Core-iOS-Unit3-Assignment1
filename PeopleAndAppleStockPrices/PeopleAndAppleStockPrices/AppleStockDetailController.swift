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

