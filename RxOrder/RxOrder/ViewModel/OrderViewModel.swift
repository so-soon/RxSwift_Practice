//
//  OrderViewModel.swift
//  RxOrder
//
//  Created by Randy on 2021/03/07.
//

import Foundation
import RxSwift
import RxCocoa

class OrderViewModel {
    //MARK:- Properties
    var disposeBag : DisposeBag = DisposeBag()
    
    // MARK: - Reactive INPUT
    
    // MARK: - Reactive OUTPUT
    var orderedItemText : BehaviorRelay<String> = BehaviorRelay(value: "")
    var totalPrice : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var vat : BehaviorRelay<Double> = BehaviorRelay(value: 0.0)
    
    
    
    init(selectedData : [MenuItemViewModel] = []) {
        // MARK: - Reactive OUTPUT
        
        let data = Observable.from(selectedData)
        
        data
            .map({ "\($0.name)\n" })
            .scan("", accumulator: +)
            .bind(to: orderedItemText)
            .disposed(by: disposeBag)

        data
            .map({$0.price * $0.count})
            .reduce(0, accumulator: +)
            .bind(to: totalPrice)
            .disposed(by: disposeBag)
        
        totalPrice
            .map({Double($0)*0.1})
            .bind(to: vat)
            .disposed(by: disposeBag)
    }
    
    
}
