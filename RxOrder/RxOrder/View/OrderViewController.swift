//
//  OrderViewController.swift
//  RxOrder
//
//  Created by Randy on 2021/03/07.
//

import UIKit

class OrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Interface Builder Links
    
    @IBOutlet weak var tvOrderedItem: UITextView!
    
    @IBOutlet weak var lbTotalPriceItem: UILabel!
    @IBOutlet weak var lbVAT: UILabel!
    
    @IBOutlet weak var lbTotalPrice: UILabel!
    
}
