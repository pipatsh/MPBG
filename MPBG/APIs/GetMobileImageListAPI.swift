//
//  GetMobileImageListAPI.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 5/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

struct GetMobileImageListAPI: APIRequest
{
  var id: Int
  
  var urlString: String
  {
    
    return "https://scb-test-mobile.herokuapp.com"
  }
  
  var path: String?
  {
    return "api/mobiles/\(id)/images"
  }
  
  var ignoredParameters: [String] {
    return ["id"]
  }
}
