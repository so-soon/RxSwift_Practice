//
//  MainViewModel.swift
//  RxFacebookMe
//
//  Created by Randy on 2021/03/08.
//
import Foundation
import RxCocoa
import RxSwift
import RxDataSources


class MainViewModel {
    let dataSources : RxTableViewSectionedReloadDataSource<SectionModel<String,CellInfo>>
    
    var cells : [SectionModel<String,CellInfo>] = [
        SectionModel(model: SectionTitle.getTitle(section: 0), items: []),
        SectionModel(model: SectionTitle.getTitle(section: 1), items: []),
        SectionModel(model: SectionTitle.getTitle(section: 2), items: []),
        SectionModel(model: SectionTitle.getTitle(section: 3), items: []),
        SectionModel(model: SectionTitle.getTitle(section: 4), items: [])
    ]
    
    var bag : DisposeBag = DisposeBag()
    
    // MARK: - Reactive INPUT
    // MARK: - Reactive OUTPUT
    let cellsObservable : BehaviorRelay<[SectionModel<String,CellInfo>]> = BehaviorRelay(value: [])
    
    init() {
        
        
        // MARK: - Reactive OUTPUT
        dataSources = RxTableViewSectionedReloadDataSource<SectionModel<String,CellInfo>>(
            configureCell: {(_, tv, indexPath, element) -> UITableViewCell in
                let cell = tv.dequeueReusableCell(withIdentifier : "Cell")!
                
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
        
        APIService.shared.getDataFromURL()
            .subscribe(onNext:{ [self] cellArray in
                cellArray.forEach({cell in
                    self.cells[cell.section].items.append(cell)
                })
            })
            .disposed(by: bag)
    
        
        
    }
}
