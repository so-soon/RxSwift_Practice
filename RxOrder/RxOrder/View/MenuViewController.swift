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
        if segue.identifier ?? "" == OrderViewController.segueIdFromMenu{
            guard let selectedDataArray = sender as? [MenuItemViewModel] else{return}
            guard let orderVC = segue.destination as? OrderViewController else{return}
            
            let orderViewModel = OrderViewModel(selectedData: selectedDataArray)
            
            orderVC.viewModel = orderViewModel
            
        }
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
                self?.performSegue(withIdentifier: OrderViewController.segueIdFromMenu, sender: selectedDataArray)
            })
            .disposed(by: disposeBag)
        
        // MARK: - Reactive OUTPUT
        
        viewModel.itemCount
            .map({"\($0) items"})
            .bind(to: lbItemCount.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .map({"\($0)"})
            .bind(to: lbTotalPrice.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.menuDataForTableView
            .bind(to: tbvMenuList.rx.items(cellIdentifier: MenuItemTableViewCell.identifier, cellType: MenuItemTableViewCell.self)){
                (row, model, cell) in
                
                // MARK: - Reactive INPUT
                cell.btnIncreaseCount.rx.tap
                    .map({(model,1)})
                    .bind(to: self.viewModel.changeItemCount)
                    .disposed(by: cell.disposeBag)
                
                cell.btnDecreaseCount.rx.tap
                    .map({(model,-1)})
                    .bind(to: self.viewModel.changeItemCount)
                    .disposed(by: cell.disposeBag)
                
                
                // MARK: - Reactive OUTPUT
                self.viewModel.menuDataForTableView
                    .map({$0[row].name})
                    .bind(to: cell.lbMenuName.rx.text)
                    .disposed(by: cell.disposeBag)
                
                self.viewModel.menuDataForTableView
                    .map({"\($0[row].price)"})
                    .bind(to: cell.lbMenuPrice.rx.text)
                    .disposed(by: cell.disposeBag)
                
                self.viewModel.menuDataForTableView
                    .map({"\($0[row].count)"})
                    .bind(to: cell.lbMenuCount.rx.text)
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
        
        viewModel.isLoading
            .bind(to: aiLoadingMenu.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .map{!$0}
            .bind(to: aiLoadingMenu.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    
    //MARK:- Interface Builder Links

    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var lbItemCount: UILabel!
    @IBOutlet weak var lbTotalPrice: UILabel!
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var tbvMenuList: UITableView!
    @IBOutlet weak var aiLoadingMenu: UIActivityIndicatorView!
}

