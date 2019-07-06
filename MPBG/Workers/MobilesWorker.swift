//
//  MobilesWorker.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

class MobilesWorker
{
  var mobilesStore: MobilesStoreProtocol
  
  init(mobilesStore: MobilesStoreProtocol)
  {
    self.mobilesStore = mobilesStore
  }
  
  func fetchMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
  {
    mobilesStore.fetchMobiles(completionHandler: completionHandler)
  }
  
  func fetchMobileImages(id: Int, completionHandler: @escaping ([MobileImage]?, DataError?) -> Void)
  {
    mobilesStore.fetchMobileImages(id: id, completionHandler: completionHandler)
  }
  
  func fetchFavoriteMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
  {
    mobilesStore.fetchFavouriteMobiles { (mobiles, error) in
      DispatchQueue.main.async {
        completionHandler(mobiles, error)
      }
    }
  }
  
  func addFavouriteMobile(mobile: Mobile, completionHandler: @escaping (Mobile?, DataError?) -> Void)
  {
    mobilesStore.addFavouriteMobile(mobile: mobile) { (mobile, error) in
      DispatchQueue.main.async {
        completionHandler(mobile, error)
      }
    }
  }
  
  func deleteFavouriteMobile(id: Int, completionHandler: @escaping (Mobile?, DataError?) -> Void)
  {
    mobilesStore.deleteFavouriteMobile(id: id) { (mobile, error) in
      DispatchQueue.main.async {
        completionHandler(mobile, error)
      }
    }
  }
}

protocol MobilesAPIProtocol
{
  
}

protocol MobilesStoreProtocol
{
  func fetchMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
  func fetchMobileImages(id: Int, completionHandler: @escaping ([MobileImage]?, DataError?) -> Void)
  func fetchFavouriteMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
  func addFavouriteMobile(mobile: Mobile, completionHandler: @escaping (Mobile?, DataError?) -> Void)
  func deleteFavouriteMobile(id: Int, completionHandler: @escaping (Mobile?, DataError?) -> Void)
}

