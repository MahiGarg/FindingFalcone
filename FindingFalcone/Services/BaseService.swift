//
//  BaseService.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 13/09/23.
//

import Foundation
import Alamofire

class BaseService{
    
    let BASE_URL = "https://findfalcone.geektrust.com"
    
    func makeGetRequest<T: Codable>(endpoint: String,
                                    onSuccess: @escaping (T)-> Void,
                                    onError: @escaping (AFError)-> Void){
        AF.request(BASE_URL + endpoint,
                   method: .get,
                   encoding: URLEncoding.queryString)
        .responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                print(data)
                onSuccess(data)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func makePostRequest<T: Codable>(endpoint: String,
                                     header: HTTPHeaders? = nil,
                                     body:[String: Any]? = nil,
                                     onSuccess: @escaping (T)-> Void,
                                     onError: @escaping (AFError)-> Void){
        AF.request(BASE_URL + endpoint,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                onSuccess(data)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
}
