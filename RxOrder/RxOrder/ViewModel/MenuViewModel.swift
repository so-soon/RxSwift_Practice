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
    let isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    init() {
        // MARK: - Reactive INPUT
        clearMenuList
            .withLatestFrom(menuDataForTableView)
            .map({ $0.map({ MenuItemViewModel(id: $0.id, name: $0.name, price: $0.price, count: 0) }) })
            .subscribe(onNext: menuDataForTableView.onNext)
            .disposed(by: disposeBag)
        
        showOrderPage
            .withLatestFrom(menuDataForTableView)
            .map({$0.filter({$0.count != 0}) })
            .bind(to: selectedMenuData)
            .disposed(by: disposeBag)
        
        // MARK: - Reactive OUTPUT
        isLoading.accept(true)
        
        APIService.shared.getDataFromURL().subscribe(onNext:{
            menuData in
            self.menuDataForTableView.onNext(menuData)
        })
        .disposed(by: disposeBag)
        
        menuDataForTableView
            .map({$0.count == 0})
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
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
                        return MenuItemViewModel(id: original.id, name: original.name, price: original.price, count: max(original.count+updated.inc,0))
                    }else{return original}
                })
            }
            .bind(to: menuDataForTableView)
            .disposed(by: disposeBag)
        
        
    }
}
