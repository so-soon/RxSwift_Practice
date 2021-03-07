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

    let disposeBag : DisposeBag = DisposeBag()
    
    // MARK: - Reactive INPUT
    let clearMenuList : PublishSubject<Void> = PublishSubject()
    let showOrderPage : PublishSubject<Void> = PublishSubject()
    
    let changeItemCount : PublishSubject<(menu: MenuItemViewModel,inc: Int)> = PublishSubject()
    
    // MARK: - Reactive OUTPUT
    let menuDataForTableView : BehaviorSubject<[MenuItemViewModel]> = BehaviorSubject(value: [])
    let selectedMenuData : PublishSubject<[MenuItemViewModel]> = PublishSubject()
    let itemCount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let totalPrice : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    init() {
        // MARK: - Reactive INPUT
        clearMenuList
            .withLatestFrom(menuDataForTableView)
            .map({ $0.map({ MenuItemViewModel(id: $0.id, name: $0.name, price: $0.price, count: 0) }) })
            .subscribe(onNext: menuDataForTableView.onNext)
            .disposed(by: disposeBag)
        
        showOrderPage
            .withLatestFrom(menuDataForTableView)
            .filter({$0.count != 0 })
            .bind(to: selectedMenuData)
            .disposed(by: disposeBag)
            
        
        // MARK: - Reactive OUTPUT
        let menuData : [MenuItemViewModel] = [
            MenuItemViewModel(id: "0", name: "감자", price: 100, count: 0),
            MenuItemViewModel(id: "1", name: "고구마", price: 100, count: 0),
            MenuItemViewModel(id: "2", name: "김치", price: 100, count: 0),
            MenuItemViewModel(id: "3", name: "치즈", price: 100, count: 0)
        ] // Todo : load from json,remove dummy
        menuDataForTableView.onNext(menuData)
        
        menuDataForTableView
            .map({$0.map({ $0.count }).reduce(0, +)})
            .bind(to: itemCount)
            .disposed(by: disposeBag)
        
        menuDataForTableView
            .map({$0.map({ $0.price * $0.count}).reduce(0, +)})
            .bind(to: totalPrice)
            .disposed(by: disposeBag)
        
        changeItemCount
            .withLatestFrom(menuDataForTableView){ (updated, originalArray) in
                originalArray.map( { original -> MenuItemViewModel in
                    if original.id == updated.menu.id{
                        return MenuItemViewModel(id: original.id, name: original.name, price: original.price, count: original.count+updated.inc)
                    }else{return original}
                })
            }
            .bind(to: menuDataForTableView)
            .disposed(by: disposeBag)
        
        
    }
}
