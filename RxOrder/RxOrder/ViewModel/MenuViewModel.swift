//
//  MenuViewModel.swift
//  RxOrder
//
//  Created by Randy on 2021/03/07.
//
import RxSwift
import RxCocoa

class MenuViewModel {
    //MARK:- Properties
    private var menuData : [MenuViewModel] = [] // Todo : load from json
    let disposeBag : DisposeBag = DisposeBag()
    
    // MARK: - Reactive INPUT
    let clearMenuList : PublishSubject<Void> = PublishSubject()
    let showOrderPage : PublishSubject<Void> = PublishSubject()
    
    // MARK: - Reactive OUTPUT
    let menuDataForTableView : BehaviorSubject<[MenuViewModel]> = BehaviorSubject(value: [])
    let selectedMenuData : PublishSubject<[MenuViewModel]> = PublishSubject()
    let itemCount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let totalPrice : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    init() {
        
    }
}
