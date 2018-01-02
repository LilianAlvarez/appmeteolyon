//
//  NetworkConfiguration.swift
//  Weather
//
//  Created by admin on 24/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//


import Foundation

class NetworkConfiguration {
    static let baseUrl: String = "http://api.openweathermap.org/data/2.5/"
    static let apiKey: String = "&appid=84bff7bb56afc81a4a0bbd63e4c9c366"
    static let weatherUrl: String = "\(baseUrl)forecast?q=Lyon,FR&cnt=56\(apiKey)"
    static let sunInfoUrl: String = "\(baseUrl)weather?q=Lyon\(apiKey)"
}

enum HttpErrorCode: Int {
    //HTTP ErrorCode
    case badRequest = 400 // Your request is not well formated. Look at the input
    case badCredentials = 401 // Authentication should be done
    case forbidden = 403 // The request resource need authentication, or authorization is not enough
    case notFound = 404 // The specified resource could not be found
    case notAllowed = 405 // You tried to access a resource with an invalid method
    case notAcceptable = 406 // You requested a format that isn’t json
    case tooManyRequests = 429 // You’re requesting too many kittens! Slow down!
    case internalServerError = 500 // We had a problem with our server. Try again later.
    case serviceUnavailable = 503 // We’re temporarily offline for maintenance. Please try again later.
    
    //URLConnection error Code
    case unknown                    =   -1      // Error is unknown.
    case cancelled                  =   -999    // The connection was cancelled.
    case timedOut                   =   -1_001   // The connection timed out.
    case hostNotFound               =   -1_003   // The connection failed because the host could not be found.
    case hostNotReachable           =   -1_004   // The connection failed because a connection cannot be made to the host.
    case connectionLost             =   -1_005   // The connection failed because the network connection was lost.
    case resourceUnavaible          =   -1_008   // The connection’s resource is unavailable.
    case internetUnavailable        =   -1_009   // The connection failed because the device is not connected to the internet.
    case responseInvalid            =   -1_011   // The connection received an invalid server response.
    case cannotParseResponse        =   -1_017   // The connection cannot parse the server’s response.
    case dataUseNotAllowed          =   -1_020   // The connection failed because data use is currently not allowed on the device.
    
    // Custom error code
    case notAuthentificated         =   -10_000  // Need to be connected to do this request
}

enum ErrorState: CustomStringConvertible, Error {
    case internalServerError
    case serviceUnavailable
    case timedOut
    case hostNotFound
    case hostNotReachable
    case connectionLost
    case internetUnavailable
    case notAuthentificated
    case defaultError
    case decodeError
    case unknownError
    
    var description: String {
        switch self {
        case .internalServerError:
            return "Erreur du serveur."
        case .serviceUnavailable:
            return "Le serveur est indisponible, réessayez plus tard."
        case .timedOut:
            return "Le serveur met trop de temps à répondre, réessayer plus tard."
        case .hostNotFound :
            return "Le serveur est introuvable, merci de ré essayer plus tard."
        case .hostNotReachable :
            return "Le serveur semble ne pas répondre, merci de ré essayer plus tard."
        case .connectionLost :
            return "Vous avec perdu votre connexion internet."
        case .internetUnavailable :
            return "Pas de connexion internet. Veuillez essayer ultérieurement."
        case .notAuthentificated :
            return "Vous n'êtes plus connecté."
        case .defaultError, .decodeError, .unknownError:
            return "Une erreur est survenue, merci de ré essayer plus tard."
        }
    }
    
    static func from(statusCode: Int) -> ErrorState {
        if let httpErrorCode = HttpErrorCode(rawValue:statusCode) {
            switch httpErrorCode {
            case .internalServerError :
                return ErrorState.internalServerError
            case .serviceUnavailable :
                return ErrorState.serviceUnavailable
            default:
                return ErrorState.defaultError
            }
        } else {
            return ErrorState.defaultError
        }
    }
    
    static func from(urlError: URLError) -> ErrorState {
        if let errorCode = HttpErrorCode(rawValue: urlError.errorCode){
            switch errorCode {
            case .timedOut:
                return ErrorState.timedOut
            case .hostNotFound:
                return ErrorState.hostNotFound
            case .hostNotReachable:
                return ErrorState.hostNotReachable
            case .connectionLost:
                return ErrorState.connectionLost
            case .internetUnavailable:
                return ErrorState.internetUnavailable
            case .notAuthentificated:
                return ErrorState.notAuthentificated
            default:
                return ErrorState.defaultError
            }
        } else {
            return ErrorState.unknownError
        }
    }
}
