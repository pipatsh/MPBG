//
//  FavouriteMobile+CoreDataClass.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FavouriteMobile)
public class FavouriteMobile: NSManagedObject
{
  func toMobile() -> Mobile
  {
    
    return Mobile(id: Int(id), name: name!, description: desc!, brand: brand!, thumbImageURL: thumbImageURL!, price: price, rating: rating)
  }
  
  func fromMobile(mobile: Mobile)
  {
    id = Int64(mobile.id)
    name = mobile.name
    desc = mobile.description
    brand = mobile.brand
    thumbImageURL = mobile.thumbImageURL
    price = mobile.price
    rating = mobile.rating
  }
}
