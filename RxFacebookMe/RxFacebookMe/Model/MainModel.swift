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

struct SectionTitle {
    static func getTitle(section: Int) -> String{
        switch section {
        case 1:
            return "FAVORITES"
        default:
            return ""
        }
        
        
    }
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
    let cellType : CellType
    let imgName : String?
    let title : String
    let detailTitle : String?
}

extension CellInfo : Equatable {
    static func == (lhs : CellInfo , rhs: CellInfo) -> Bool {
        return lhs.cellType == rhs.cellType &&
        lhs.section == rhs.section &&
        lhs.imgName == rhs.imgName &&
        lhs.title == rhs.title &&
        lhs.detailTitle == rhs.detailTitle
    }
}
