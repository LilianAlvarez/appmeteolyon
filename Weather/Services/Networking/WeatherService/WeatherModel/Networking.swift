//
//  Networking.swift
//  Weather
//
//  Created by admin on 24/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//


import Foundation
import Alamofire

/// Réponse simplifiée
///
/// - error: erreur renvoyée par alamofire
/// - object: objet souhaité
enum Response<T> {
    case error(ErrorState)
    case success(T)
}

protocol NetworkService {}

extension NetworkService {
    
    func get<T: Decodable>(_ url: URLConvertible, parameters: Parameters?, headers: HTTPHeaders?, completionHandler: @escaping (Response<T>) -> Void) {
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (responseJson) in
                completionHandler(Self.decodeResponse(responseJson))
        }
    }
    
}

// MARK: - Private methods
extension NetworkService {
    private static func decodeResponse<T: Decodable>(_ response:DataResponse<Any>) -> Response<T> {
        // catch error if any
        if let errorState = Self.catchErrors(response) {
            return Response.error(errorState)
        }
        if let data = response.data {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return Response.success(decodedData)
            } catch let error {
                print(error.localizedDescription)
                return Response.error(ErrorState.decodeError)
            }
        } else {
            return Response.error(ErrorState.unknownError)
        }
    }
    
    private static func catchErrors(_ response: DataResponse<Any>) -> ErrorState? {
        if let serverError = response.error as? AFError,
            let responseCode = serverError.responseCode {
            return ErrorState.from(statusCode: responseCode)
        }
        if let error = response.error as? URLError {
            return ErrorState.from(urlError: error)
        }
        return nil
    }
}
