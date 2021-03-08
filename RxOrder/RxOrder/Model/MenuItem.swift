//
//  MenuItem.swift
//  RxOrder
//
//  Created by Randy on 2021/03/07.
//

import Foundation
import Alamofire
import RxSwift

struct MenuItem : Decodable {
    let name : String
    let price : Int
}

struct MenuItemViewModel {
    let id : String
    let name : String
    let price : Int
    var count : Int
}

class APIService{
    static let shared = APIService()
    
    let baseURL : String = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"
    
    struct Response : Decodable {
        var menus : [MenuItem]
    }
    
    
    func getDataFromURL()-> Observable<[MenuItemViewModel]> {
        return Observable.create { emit in
            let dataRequest = AF.request(self.baseURL).responseJSON {
                response in
                switch response.result {
                case .success(let data):
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        
                        let responseData = try JSONDecoder().decode(Response.self, from: jsonData)
                        
                        let viewModelData = responseData.menus.map({menu -> MenuItemViewModel in MenuItemViewModel(id: String(Date().timeIntervalSince1970), name: menu.name, price: menu.price, count: 0)})
                        
                        emit.onNext(viewModelData)
                        
                    }catch(let error){
                        emit.onError(error)
                    }
                
                case .failure(let error):
                    emit.onError(error)
                }
            }
            
            return Disposables.create{
                dataRequest.cancel()
            }
        }
        
    }
}

