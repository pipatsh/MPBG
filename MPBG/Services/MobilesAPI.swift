//
//  MobilesAPI.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

class MobilesAPI: MobilesStoreProtocol
{
  private static func toDataError(_ error: Error?) -> DataError?
  {
    return error != nil ? DataError.cannotFetch(error.debugDescription) : nil
  }
  
  func fetchMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
  {
    let api = GetMobileListAPI()
    api.request { (response: APIResponse<[Mobile]>) in
      completionHandler(response.model, MobilesAPI.toDataError(response.error))
    }
  }
  
  func fetchMobileImages(id: Int, completionHandler: @escaping ([MobileImage]?, DataError?) -> Void)
  {
    let api = GetMobileImageListAPI(id: id)
    api.request { (response: APIResponse<[MobileImage]>) in
      completionHandler(response.model, MobilesAPI.toDataError(response.error))
    }
  }
  
  func fetchFavouriteMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
  {
    
  }
  
  func addFavouriteMobile(mobile: Mobile, completionHandler: @escaping (Mobile?, DataError?) -> Void)
  {
    
  }
  
  func deleteFavouriteMobile(id: Int, completionHandler: @escaping (Mobile?, DataError?) -> Void)
  {
    
  }
}

