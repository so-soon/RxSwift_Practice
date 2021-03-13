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
    
    init(id: String, farm: Int, server : String, secret: String){
        self.id = id
        self.farm = farm
        self.server = server
        self.secret = secret
        
        guard let thumnailURL = URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg") else{return}
        
        guard let largeImageURL = URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_b.jpg") else{return}
        
        guard let thumnailImageData = try? Data(contentsOf: thumnailURL) else{return}
        
        guard let largeImageData = try? Data(contentsOf: largeImageURL) else{return}
        
        self.thumnail = UIImage(data: thumnailImageData)
        self.largeImage = UIImage(data: largeImageData)
        
    }
}
