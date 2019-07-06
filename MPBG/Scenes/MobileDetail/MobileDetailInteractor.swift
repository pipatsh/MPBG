//
//  MobileDetailInteractor.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 4/7/2562 BE.
//  Copyright (c) 2562 Pipat Shuleepongchad. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MobileDetailBusinessLogic
{
  func getMobile(request: MobileDetail.GetMobile.Request)
  func fetchMobileImages(request: MobileDetail.FetchMobileImages.Request)
}

protocol MobileDetailDataStore
{
  var mobile: Mobile! { get set }
}

class MobileDetailInteractor: MobileDetailBusinessLogic, MobileDetailDataStore
{
  var presenter: MobileDetailPresentationLogic?
  var worker = MobilesWorker(mobilesStore: MobilesAPI())
  var mobile: Mobile!
  
  // MARK: Do something
  
  func getMobile(request: MobileDetail.GetMobile.Request)
  {
    let response = MobileDetail.GetMobile.Response(mobile: mobile)
    self.presenter?.presentMobile(response: response)
  }
  
  func fetchMobileImages(request: MobileDetail.FetchMobileImages.Request)
  {
    worker.fetchMobileImages(id: mobile.id, completionHandler: { [weak self] (images, error) in
      guard let self = self else { return }
      guard let images = images, error == nil else {
        return
      }
      let response = MobileDetail.FetchMobileImages.Response(mobileImages: images)
      self.presenter?.presentFetchedMobileImages(response: response)
    })
  }
}