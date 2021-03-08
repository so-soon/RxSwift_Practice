//
//  MainViewModel.swift
//  RxFacebookMe
//
//  Created by Randy on 2021/03/08.
//

import Foundation
import UIKit

enum CellType : Int {
    case kProfile = 0
    case kNormal
    case kSupport
    case kLogout
}

struct RawCellInfo : Decodable {
    let section : Int
    let cellType : Int
    let imgName : String?
    let title : String
    let detailTitle : String?
}

struct CellInfo {
    let id : String
    let section : Int
    let cellType : CellType?
    let imgName : String?
    let title : String
    let detailTitle : String?
}
