//
//  GetMobileListAPI.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

struct GetMobileListAPI: APIRequest
{
  var urlString: String
  {
    return "https://scb-test-mobile.herokuapp.com"
  }
  
  var path: String?
  {
    return "api/mobiles"
  }
}
