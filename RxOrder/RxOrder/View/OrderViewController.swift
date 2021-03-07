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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK:- Interface Builder Links
    
    @IBOutlet weak var tvOrderedItem: UITextView!
    
    @IBOutlet weak var lbTotalPriceItem: UILabel!
    @IBOutlet weak var lbVAT: UILabel!
    
    @IBOutlet weak var lbTotalPrice: UILabel!
    
}
