//
//  ViewController.swift
//  RxFacebookMe
//
//  Created by Randy on 2021/03/08.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    //MARK:- Properties
    var viewModel : MainViewModel = MainViewModel()
    var bag : DisposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func bindUI(){
        // MARK: - Reactive INPUT
        
        
        // MARK: - Reactive OUTPUT
        
        viewModel.cellsObservable
            .bind(to: tbvSettings.rx.items(dataSource: viewModel.dataSources))
            .disposed(by: bag)
    }
    
    
    //MARK:- Interface Builder Links
    @IBOutlet weak var tbvSettings: UITableView!
}

