//
//  MobileImage.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 5/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

struct MobileImage: Decodable, Equatable
{
  
  var id: Int
  var mobileId: Int
  var url: String
  
  init(id: Int, mobileId: Int, url:String)
  {
    self.id = id
    self.mobileId = mobileId
    self.url = url
  }
  
  init(from decoder: Decoder) throws
  {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.mobileId = try container.decode(Int.self, forKey: .mobileId)
    let url = try container.decode(String.self, forKey: .url)

    if url.hasPrefix("http://") || url.hasPrefix("https://") {
      self.url = url
    } else {
      self.url = "https://\(url)"
    }
  }
  
  private enum CodingKeys : String, CodingKey
  {
    case id, url, mobileId = "mobile_id"
  }
}
