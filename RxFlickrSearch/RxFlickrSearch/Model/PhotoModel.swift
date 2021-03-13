//
//  PhotoModel.swift
//  RxFlickrSearch
//
//  Created by Randy on 2021/03/12.
//

import Foundation
import UIKit

struct RawPhotoModel : Decodable {
    let id : String
    let farm : Int
    let server : String
    let secret : String
}

struct PhotoModel {
    var thumnail : UIImage?
    var largeImage : UIImage?
    
    let id : String
    let farm : Int
    let server : String
    let secret : String
}
