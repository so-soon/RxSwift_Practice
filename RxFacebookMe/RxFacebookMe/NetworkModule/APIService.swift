//
//  APIService.swift
//  RxFacebookMe
//
//  Created by Randy on 2021/03/08.
//

import Foundation
import Alamofire
import RxSwift

class APIService {
    static let shared = APIService()
    let baseURL = "https://my-json-server.typicode.com/so-soon/json_server/fbMe"
    struct Response : Decodable {
        var cellInfos : [RawCellInfo]
    }
    
    func getDataFromURL() -> Observable<[CellInfo]>{
        return Observable.create { observer in
            let request = AF.request(self.baseURL).responseJSON{
                response in
                switch response.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        
                        let rawData = try JSONDecoder().decode(Response.self, from: jsonData)
                        
                        let cellInfo = rawData.cellInfos.map({ cell -> CellInfo in return CellInfo(id: UUID().uuidString, section: cell.section, cellType: CellType(rawValue: cell.cellType), imgName: cell.imgName, title: cell.title, detailTitle: cell.detailTitle) })
                        
                        observer.onNext(cellInfo)
                        observer.onCompleted()
                        
                    }catch(let error){
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create{
                request.cancel()
            }
        }
    }
}

