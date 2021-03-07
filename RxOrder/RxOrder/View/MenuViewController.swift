//
//  ViewController.swift
//  RxOrder
//
//  Created by Randy on 2021/03/07.
//

import UIKit
import RxSwift
import RxCocoa


class MenuViewController: UIViewController {
    //MARK:- Properties
    
    let viewModel : MenuViewModel = MenuViewModel()
    var disposeBag : DisposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindingUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Todo : Impl binding between menuview and orderview
    }
    
    //MARK:- Binding UI
    func bindingUI() {
        // MARK: - Reactive INPUT
        btnClear.rx.tap
            .bind(to: viewModel.clearMenuList)
            .disposed(by: disposeBag)
        
        btnOrder.rx.tap
            .bind(to: viewModel.showOrderPage)
            .disposed(by: disposeBag)
        
        // MARK: - Reactive NAVIGATION
        
        viewModel.selectedMenuData
            .subscribe(onNext: {
                [weak self] selectedDataArray in
                self?.navigationController?.performSegue(withIdentifier: OrderViewController.segueIdFromMenu, sender: selectedDataArray)
            })
            .disposed(by: disposeBag)
        
        // MARK: - Reactive OUTPUT
        
        viewModel.itemCount
            .map({"\($0)"})
            .bind(to: lbItemCount.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .map({"\($0)"})
            .bind(to: lbTotalPrice.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.menuDataForTableView
            .bind(to: tbvMenuList.rx.items(cellIdentifier: MenuItemTableViewCell.identifier, cellType: MenuItemTableViewCell.self)){
                (row, model, cell) in
                
                // Todo : Cell rx binding
                
                
            }.disposed(by: disposeBag)
    }
    
    
    //MARK:- Interface Builder Links
    
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var lbItemCount: UILabel!
    @IBOutlet weak var lbTotalPrice: UILabel!
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var tbvMenuList: UITableView!
}

