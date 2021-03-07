//
//  MenuItem.swift
//  RxOrder
//
//  Created by Randy on 2021/03/07.
//

import Foundation

struct MenuItem : Decodable {
    let name : String
    let price : Int
}

struct MenuItemModel {
    let id : String
    let name : String
    let price : String
    var count : Int
}