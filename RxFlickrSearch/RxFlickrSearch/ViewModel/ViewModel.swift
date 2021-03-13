//
//  ViewModel.swift
//  RxFlickrSearch
//
//  Created by Randy on 2021/03/11.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    //MARK:- Properties
    var bag : DisposeBag = DisposeBag()
    
    // MARK: - Reactive INPUT
    
    let searchText : PublishSubject<String> = PublishSubject()
    let searchReturnTapped : PublishSubject<Void> = PublishSubject()
    
    
    // MARK: - Reactive OUTPUT
    let searching : PublishSubject<String> = PublishSubject()
    let photoCellData : BehaviorRelay<[PhotoModel]> = BehaviorRelay(value: [])
    
    init() {
        // MARK: - Reactive INPUT
        searchReturnTapped.withLatestFrom(searchText.filter{$0.count != 0}){
            s1,s2 in
            return s2
        }.bind(to: searching)
        .disposed(by: bag)
        
        // MARK: - Reactive OUTPUT
        
        searching
            .subscribe(onNext : {
                urlString in
                APIService.shared.photoSearch(with: urlString)
                    .subscribe(onNext:{
                        dataArray in
                        self.photoCellData.accept(dataArray)
                    }).disposed(by: self.bag)
            }).disposed(by: bag)
        
        
    }
    
    
}
