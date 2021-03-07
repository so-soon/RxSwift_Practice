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
    var viewModel : MenuViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    //MARK:- Interface Builder Links
    
    @IBOutlet weak var lbMenuName: UILabel!
    @IBOutlet weak var lbMenuCount: UILabel!
    @IBOutlet weak var lbMenuPrice: UILabel!

    @IBOutlet weak var btnIncreaseCount: UIButton!
    @IBOutlet weak var btnDecreaseCount: UIButton!
    
}
