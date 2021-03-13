//
//  ViewController.swift
//  RxFlickrSearch
//
//  Created by Randy on 2021/03/11.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    //MARK:- Properties
    var bag : DisposeBag = DisposeBag()
    let viewModel : ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        // Do any additional setup after loading the view.
    }
    
    
    func bindUI(){
        // MARK: - Reactive INPUT
        tfSearch.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: bag)
        
        tfSearch.rx.controlEvent([.editingDidEndOnExit]).asObservable()
            .debug("enter")
            .bind(to: viewModel.searchReturnTapped)
            .disposed(by: bag)
        
        // MARK: - Reactive OUTPUT
        
        viewModel.photoCellData
            .bind(to: cvPhoto.rx.items(cellIdentifier: PhotoCollectionViewCell.identifier, cellType: PhotoCollectionViewCell.self)){
                (row,model,cell) in
                cell.ivPhoto.image = model.thumnail
            }
            .disposed(by: bag)
        
    }
    //MARK:- Interface Builder Links
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var cvPhoto: UICollectionView!
    
    
}

