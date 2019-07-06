//
//  API.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequest
{
  var urlString: String { get }
  
  var path: String? { get }
  
  var method: HTTPMethod { get }
  
  var encoding:ParameterEncoding { get }
  
  var fullPath: String { get }
  
  var header: HTTPHeaders? { get }
  
  func request<T: Decodable>(handler: @escaping (APIResponse<T>) -> Void)

  var parameters: [String: Any] { get }
  
  var ignoredParameters: [String] { get }
}

extension APIRequest
{
  var urlString: String
  {
    return "https://scb-test-mobile.herokuapp.com/api"
  }
  
  var path: String?
  {
    return nil
  }
  
  var method: HTTPMethod
  {
    return .get
  }
  
  var encoding:ParameterEncoding
  {
    switch method {
    case .get:
      return URLEncoding.default
    default:
      return JSONEncoding.default
    }
  }

  var fullPath: String
  {
    if let path = path {
      return "\(urlString)/\(path)"
    } else {
      return urlString
    }
  }
  
  var header: HTTPHeaders?
  {
    return nil
  }
  
  func request<T: Decodable>(handler: @escaping (APIResponse<T>) -> Void)
  {
    Alamofire
      .request(fullPath, method: method,
               parameters: parameters,
               encoding: encoding,
               headers: header)
      .responseJSON { response in
        if let error = response.error {
          handler(APIResponse<T>(error: error))
        } else if let data = response.data,
          let r = try? APIResponse<T>(data: data) {
          handler(r)
        } else {
          let error = APIError.failedToDecode("failed to decode.")
          handler(APIResponse<T>(error: error))
        }
    }
  }

  var parameters: [String: Any]
  {
    let mirroredObject = Mirror(reflecting: self)
    var json: [String: Any] = [:]
    for (_, attr) in mirroredObject.children.enumerated() {

      guard let key = attr.label,
        !ignoredParameters.contains(key) else {
        continue
      }
      
      let value = attr.value
      
      if let value = value as? AnyHashable {
        json[key] = value
      }

    }
    
    return json
    }
  
  var ignoredParameters: [String]
  {
    return []
  }
}

struct APIResponse<T: Decodable>
{
  let error: Error?
  let model: T?
  
  init(error: Error)
  {
    self.error = error
    model = nil
  }
  
  init(data: Data) throws
  {
    model = try JSONDecoder().decode(T.self, from: data)
    error = nil
  }
}

enum APIError: Equatable, Error
{
  case failedToDecode(String)
}
