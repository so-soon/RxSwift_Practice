//
//  APIService.swift
//  RxFlickrSearch
//
//  Created by Randy on 2021/03/11.
//
import Foundation
import RxSwift
import Alamofire

enum searchError : Error {
    case kEscapeTermError
    case kURLConversionError
    case kUnknownAPIResponseError
}

class APIService{
    static let shared : APIService = APIService()
    let apiKey = "YOUR_API_KEY_HERE"
    
    struct Response : Decodable {
        struct RawPhotos :Decodable {
            let photo : [RawPhotoModel]
        }
        let stat : String
        let photos : RawPhotos
    }
    
    func photoSearch(with searchTerm : String) -> Observable<[RawPhotoModel]> {
        return Observable.create({emitter in
            guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else{
                return emitter.onError(searchError.kEscapeTermError) as! Disposable
            }
            
            let urlString =  "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(self.apiKey)&text=\(escapedTerm)&per_page=20&format=json&nojsoncallback=1"
            
            guard let url = URL(string: urlString) else{
                return emitter.onError(searchError.kURLConversionError) as! Disposable
            }
            
            let request = AF.request(url).responseJSON(){
                reponse in
                switch reponse.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        
                        let photoData = try JSONDecoder().decode(Response.self, from: jsonData)
                        
                        emitter.onNext(photoData.photos.photo)
                        emitter.onCompleted()
                    }catch(let error){
                        emitter.onError(error)
                    }
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create(){
                request.cancel()
            }
        })
    }
}
