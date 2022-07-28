//
//  APIService.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation
import Alamofire

final class APIService {
    
    let BASE_URL: String = "https://desolate-shelf-18786.herokuapp.com"
    
    private init() {}
    
    static let shared = APIService()
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T?, ErrorModel>) -> Void
    ) {
        let urlString = "\(BASE_URL)/\(endpoint.path)"
        
        print("\n\(endpoint.method.rawValue) \(urlString)\nparameters: \(endpoint.parameters ?? Parameters())\n")
        
        let dataRequest = AF.request(
            urlString,
            method: endpoint.method,
            parameters: endpoint.parameters,
            headers: endpoint.headers
        )
        
        dataRequest.response { result in
            if let error = result.error {
                print("Error:", error)
                
                completion(.failure(.init(
                    key: nil,
                    statusCode: nil,
                    title: "Internal Error",
                    message: error.localizedDescription
                )))
                
                return
            }
            
            guard let response = result.response else {
                print("Error:", "Nil Response")
                
                completion(.failure(.init(
                    key: nil,
                    statusCode: nil,
                    title: "Nil Response",
                    message: "An error has occurred."
                )))
                
                return
            }
            
            guard (200 ..< 300) ~= response.statusCode else {
                if let data = result.data {
                    do {
                        let decodedData = try JSONDecoder().decode(ErrorModel.self, from: data)
                        
                        completion(.failure(decodedData))
                    } catch {
                        print("Error:", error)
                        
                        completion(.failure(.init(
                            key: nil,
                            statusCode: response.statusCode,
                            title: "\(ErrorModel.self) Decode Error",
                            message: error.localizedDescription
                        )))
                    }
                } else {
                    print("Error:", "Nil Error")
                    
                    completion(.failure(.init(
                        key: nil,
                        statusCode: response.statusCode,
                        title: "Nil Error",
                        message: "An error has occurred."
                    )))
                }
                
                return
            }
            
            if let data = result.data {
                do {
                    let decodedData = try JSONDecoder().decode(T?.self, from: data)
                    
                    completion(.success(decodedData))
                } catch {
                    print("Error:", error)
                    
                    completion(.failure(.init(
                        key: nil,
                        statusCode: response.statusCode,
                        title: "\(T.self) Decode Error",
                        message: error.localizedDescription
                    )))
                }
            } else {
                completion(.success(nil))
            }
        }
    }
}
