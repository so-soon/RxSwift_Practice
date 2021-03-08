//
//  OrderViewController.swift
//  RxOrder
//
//  Created by Randy on 2021/03/07.
//

import UIKit
import RxSwift
import RxCocoa


class OrderViewController: UIViewController {
    //MARK:- Properties
    static let segueIdFromMenu : String = "OrderViewController"
    var viewModel : OrderViewModel = OrderViewModel()
    var bag : DisposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        // Do any additional setup after loading the view.
    }
    
    func bindUI(){
        // MARK: - Reactive INPUT
        
        
        
        // MARK: - Reactive NAVIGATION
        
        
        
        // MARK: - Reactive OUTPUT
        
        viewModel.totalPrice
            .map({"\($0)"})
            .bind(to: lbTotalPriceItem.rx.text)
            .disposed(by: bag)
        
        viewModel.vat
            .map({"\($0)"})
            .bind(to: lbVAT.rx.text)
            .disposed(by: bag)
        
        viewModel.orderedItemText
            .bind(to: tvOrderedItem.rx.text)
            .disposed(by: bag)
        
        Observable.combineLatest(viewModel.totalPrice, viewModel.vat){
            (s1,s2) -> Double in
            return Double(s1)+s2
        }
        .map{"\($0)"}
        .bind(to: lbTotalPrice.rx.text)
        .disposed(by: bag)
        
        
        
    }
    
    //MARK:- Interface Builder Links
    
    @IBOutlet weak var tvOrderedItem: UITextView!
    
    @IBOutlet weak var lbTotalPriceItem: UILabel!
    @IBOutlet weak var lbVAT: UILabel!
    
    @IBOutlet weak var lbTotalPrice: UILabel!
    
}
