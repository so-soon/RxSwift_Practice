//
//  MenuItemTableViewCell.swift
//  RxOrder
//
//  Created by Randy on 2021/03/07.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Interface Builder Links
    
    @IBOutlet weak var lbMenuName: UILabel!
    @IBOutlet weak var lbMenuCount: UILabel!
    @IBOutlet weak var lbMenuPrice: UILabel!
    
    @IBAction func pressedBtnIncreaseItemCount(_ sender: UIButton) {
    }
    
    @IBAction func preseedBtnDecreaseItemCount(_ sender: UIButton) {
    }
    

}
