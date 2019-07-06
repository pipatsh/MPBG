//
//  MobileDetailModels.swift
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

enum MobileDetail
{
  // MARK: Use cases
  
  enum FetchMobileImages
  {
    struct Request
    {
      
    }
    
    struct Response
    {
      let mobileImages: [MobileImage]
    }
    
    struct ViewModel
    {
      let images: [String]
    }
  }
  
  enum GetMobile
  {
    struct Request
    {
      
    }
    
    struct Response
    {
      let mobile: Mobile
    }
    
    struct ViewModel
    {
        var name: String
        var description: String
        var price: String
        var rating: String
    }
  }
}