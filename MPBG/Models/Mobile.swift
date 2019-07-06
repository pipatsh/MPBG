//
//  Mobile.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

struct Mobile: Decodable, Equatable
{
  
  var id: Int
  var name: String
  var description: String
  var brand: String
  var thumbImageURL: String
  var price: Double
  var rating: Double
  
}

func ==(lhs: Mobile, rhs: Mobile) -> Bool
{
  return lhs.id == rhs.id
}

