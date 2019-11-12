//
//  APIService.swift
//  SinoPacCloud
//
//  Created by P on 2018/1/5.
//  Copyright © 2018年 Sinopac. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]
typealias APIResponseCompletionHandler = (SerivceResult) -> Void
typealias NetworkingCompletionHandler = (JSON?, NetworkingError?) -> Void
typealias NetworkingDownloadCompletionHandler = (SerivceResult) -> Void

enum APIError: Error {
    case failedResponse(message: String)
    case serviceError
    case unauthorized
    case jsonFormatError
    case unknow
}

enum SerivceResult {
    case success(Any)
    case failure(APIError)
}

class APIService {
    static let shared = APIService()
    let networking = Networking.shared
    
    private var baseURL: String {
        #if DEBUG
        //SIT
        //            return "http://10.11.34.80"
        //UAT
        return "http://10.11.42.205"
        #else
        return "http://10.16.1.45"
        #endif
    }
    
    private var WSPort: String {
        #if DEBUG
        return ":8081"
        #else
        return ":8081"
        #endif
    }
    
    private var EDMPort: String {
        #if DEBUG
        return ":9000"
        #else
        return ":8080"
        #endif
    }
    
    private var EDMWSPort: String {
        #if DEBUG
        return ":9090"
        #else
        return ":9090"
        #endif
    }
    
    private enum FeatureURL: String {
        case searchSPSContacts = "Service/SearchSPSContacts"
    }
    
    func getData(urlString: String,completionHandler: @escaping APIResponseCompletionHandler) {
        networking.get(urlString: urlString) { (json, error) in
            guard error == nil else {
                completionHandler(.failure(.serviceError))
                return
            }
            print("88888888\(json)")
            
            guard let json = json else {
                completionHandler(.failure(.jsonFormatError))
                return
            }
            
            completionHandler(.success(json))
        }
    }
    
    func postData(data: [String: Any], urlString: String, completionHandler: @escaping APIResponseCompletionHandler) {
        networking.post(urlString: urlString, parameters: data) { (json, error) in
            guard error == nil else {
               
                completionHandler(.failure(.serviceError))
                return
            }
            
            guard let json = json else {
                completionHandler(.failure(.jsonFormatError))
                return
            }
            
            print("66666666\(json)")
            
            if json["Success"] is Bool {
                completionHandler(.success(json))
            } else {
                guard let message = json["ReturnMessage"] as? String else {
                    completionHandler(.failure(.failedResponse(message: "")))
                    return
                }
                completionHandler(.failure(.failedResponse(message: message)))
            }
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HTTPHeader {
    enum Key: String {
        case contentType = "Content-Type"
    }
    
    enum Value: String {
        case json = "application/json"
    }
}

enum NetworkingError: Error {
    case failedRequest
    case invalidResponse
    case unauthorized
    case unknown
    case successButResponseIsNotJson
}

struct StatusCode {
    static let success = 200
    static let badRequest = 400
    static let unauthorized = 401
}



class Networking {
    static let shared = Networking()
    
    let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        return URLSession(configuration: configuration)
    }()
    
    var sessionForDelegate: URLSession?
    
    
    // Data Task
    func get(urlString: String, completionHandler: @escaping NetworkingCompletionHandler) {
        guard let url = URL(string: urlString) else {
            print("url error")
            return
        }
        
        var request = URLRequest(url: url)
        print("URL: \(request)")
        request.httpMethod = HTTPMethod.get.rawValue
        
        // HTTP Header
        request.addValue(HTTPHeader.Value.json.rawValue, forHTTPHeaderField: HTTPHeader.Key.contentType.rawValue)
        print("Header: \(request.allHTTPHeaderFields!)")
        
        fetchedData(from: request, completionHandler: completionHandler)
    }
    
    func post<T>(urlString: String, parameters: T, completionHandler: @escaping NetworkingCompletionHandler) {
        guard let url = URL(string: urlString) else {
            print("url error")
            return
        }
        
        var request = URLRequest(url: url)
        print("URL: \(request)")
        request.httpMethod = HTTPMethod.post.rawValue
        
        // HTTP Header
        request.addValue(HTTPHeader.Value.json.rawValue, forHTTPHeaderField: HTTPHeader.Key.contentType.rawValue)
        
        print("Header: \(request.allHTTPHeaderFields!)")
        
        var encryptBody = ""
        print("Body: \(parameters)")
        switch T.self {
        case is String.Type:
            encryptBody = parameters as! String
            print("Encrypt Body: \(encryptBody)")
        case is JSON.Type:
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
                let jsonString = String(data: jsonData, encoding: .utf8) ?? "JSON String is nil"
                print("Body JSON String: \(jsonString)")
                encryptBody = jsonString
                print("Encrypt Body: \(encryptBody)")
            } catch let error {
                print(error.localizedDescription)
            }
        default: break
        }
        
        request.httpBody = encryptBody.data(using: .utf8)
        
        fetchedData(from: request, completionHandler: completionHandler)
    }
    
    func fetchedData(from request: URLRequest, completionHandler: @escaping NetworkingCompletionHandler) {
        //for AirWatch
        //AirWatch can't use the smae URLSeesion
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        let newSession = URLSession(configuration: configuration)
        
        newSession.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                completionHandler(nil, .failedRequest)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Response is nil")
                completionHandler(nil, .unknown)
                return
            }
            
            guard let data = data else {
                print("Data is nil")
                completionHandler(nil, .unknown)
                return
            }
            
            print("Response: \(response)")
            switch response.statusCode {
            case StatusCode.success:
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        print("JsonObject is nil")
                        completionHandler(nil, .successButResponseIsNotJson)
                        return
                    }
                    print("JSON Object: \(jsonObject)")
                    completionHandler(jsonObject, nil)
                } catch let error {
                    //special case
                    //UpdateAppVersion Api retrun null if success
                    let respond = String(data: data, encoding: String.Encoding.utf8) as String?
                    if respond == "null" {
                        completionHandler(["Success":true], nil)
                        return
                    }
                    
                    completionHandler(nil, .successButResponseIsNotJson)
                    print(error.localizedDescription)
                }
            case StatusCode.unauthorized:
                completionHandler(nil, .unauthorized)
            default:
                completionHandler(nil, .failedRequest)
            }
            }.resume()
    }
    
    // Download Task
    func downloadFile(to destinationUrl: URL, fileName: String, urlString: String, completionHandler: @escaping NetworkingDownloadCompletionHandler) {
        //解決url含中文問題
        var encodeURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        encodeURL = (encodeURL?.replacingOccurrences(of: "%3A", with: ":").replacingOccurrences(of: "%2F", with: "/").replacingOccurrences(of: "%25", with: "%"))
        
        guard let url = URL(string: encodeURL!) else {
            print("url error")
            return
        }
        
        var request = URLRequest(url: url)
        print("URL: \(request)")
        request.httpMethod = HTTPMethod.get.rawValue
        
        // HTTP Header
        request.addValue(HTTPHeader.Value.json.rawValue, forHTTPHeaderField: HTTPHeader.Key.contentType.rawValue)
        print("Header: \(request.allHTTPHeaderFields!)")
        
        downloadFile(to: destinationUrl, fileName: fileName, from: request, completionHandler: completionHandler)
    }
    
    func downloadFile(to destinationUrl: URL, fileName: String, from request: URLRequest, completionHandler: @escaping NetworkingDownloadCompletionHandler) {
        //for AirWatch
        //AirWatch can't use the smae URLSeesion
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        let newSession = URLSession(configuration: configuration)
        
        newSession.dataTask(with: request) { (data, response, error) in
            print("(url, response, error) = (\(String(describing: data)), \(String(describing: response)), \(String(describing: error)))")
            guard error == nil else {
                completionHandler(.failure(.serviceError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode != StatusCode.badRequest else {
                completionHandler(.failure(.serviceError))
                return
            }
            
            guard let responseData = data else {
                completionHandler(.failure(.serviceError))
                return
            }
            
            do {
                try responseData.write(to: destinationUrl)
                
                completionHandler(.success(destinationUrl))
                print("Written file \(fileName) : \(destinationUrl)")
                
            } catch  {
                completionHandler(.failure(.failedResponse(message: error.localizedDescription)))
                print("error writing file \(fileName) : \(error)")
            }
            }.resume()
    }
    
}
