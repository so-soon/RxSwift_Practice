//
//  MenuItemTableViewCell.swift
//  RxOrder
//
//  Created by Randy on 2021/03/07.
//

import UIKit
import RxSwift

class MenuItemTableViewCell: UITableViewCell {
    //MARK:- Properties
    static let identifier : String = "MenuItemTableViewCell"
    var disposeBag : DisposeBag = DisposeBag()
    private let cellDisposeBag : DisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
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
