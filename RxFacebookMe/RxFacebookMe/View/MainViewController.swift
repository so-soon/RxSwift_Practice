//
//  ViewController.swift
//  RxFacebookMe
//
//  Created by Randy on 2021/03/08.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {
    //MARK:- Properties
    var viewModel : MainViewModel = MainViewModel()
    var bag : DisposeBag = DisposeBag()
    var dataSources : RxTableViewSectionedReloadDataSource<SectionModel<String,CellInfo>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindUI()
    }

    func bindUI(){
        // MARK: - Reactive INPUT
        
        
        // MARK: - Reactive OUTPUT
        dataSources = RxTableViewSectionedReloadDataSource<SectionModel<String,CellInfo>>(
            configureCell: {(_, tv, indexPath, element) -> UITableViewCell in
                let cell = tv.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseId[element.cellType.rawValue])!
                
                cell.imageView?.image = UIImage(named: element.imgName ?? "")
                cell.textLabel?.text = element.title
                cell.detailTextLabel?.text = element.detailTitle
                
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
        
        viewModel.cellsObservable
            .bind(to: tbvSettings.rx.items(dataSource: dataSources!))
            .disposed(by: bag)
    }
    
    
    //MARK:- Interface Builder Links
    @IBOutlet weak var tbvSettings: UITableView!
}

