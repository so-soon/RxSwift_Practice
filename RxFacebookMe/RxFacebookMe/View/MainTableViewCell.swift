//
//  MainTableViewCell.swift
//  RxFacebookMe
//
//  Created by Randy on 2021/03/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let reuseId : [String] = [
        "CellType0TableViewCell",
        "CellType1TableViewCell",
        "CellType2TableViewCell",
        "CellType3TableViewCell"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
