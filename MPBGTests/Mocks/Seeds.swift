//
//  Seeds.swift
//  MPBGTests
//
//  Created by Pipat Shuleepongchad on 6/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

@testable import MPBG
import XCTest

struct Seeds {
  
  struct MobileListDisplay {
    static let motoG5 = MobileList.DisplayedMobile(id: 1, name: "Moto G5", description: "Description", thumbImageURL: "https://abc.com/image.png", price: "$165.0", rating: "3.8", isFavourite: false)
    static let sonyL1 = MobileList.DisplayedMobile(id: 2, name: "Sony Xperia L1", description: "Description", thumbImageURL: "https://abc.com/image.png", price: "$171.99", rating: "4.3", isFavourite: true)
  }
  
  struct MobileDetailDisplay {
    static let motoG5 = MobileDetail.GetMobile.ViewModel(name: "Moto G5", description: "Description", price: "$165.0", rating: "3.8")
  }
  
  struct MobileModel {
    static let motoG5 = Mobile(id: 1, name: "Moto G5", description: "Description", brand: "Moto", thumbImageURL: "https://abc.com/image.png", price: 165, rating: 3.8)
    static let sonyL1 = Mobile(id: 2, name: "Sony Xperia L1", description: "Description", brand: "Moto", thumbImageURL: "https://abc.com/image.png", price: 171.99, rating: 4.3)
  }
  
  struct MobileImageModel {
    static let motoG5Image1 = MobileImage(id: 1, mobileId: 1, url: "https://www.abc.com/image.jpg")
    static let motoG5Image2 = MobileImage(id: 2, mobileId: 1, url: "https://www.abc.com/image.jpg")
  }
  
}
