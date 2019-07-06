//
//  MobileListRouter.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright (c) 2562 Pipat Shuleepongchad. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol MobileListRoutingLogic
{
  func routeToMobileDetail(segue: UIStoryboardSegue?)
}

protocol MobileListDataPassing
{
  var dataStore: MobileListDataStore? { get }
}

class MobileListRouter: NSObject, MobileListRoutingLogic, MobileListDataPassing
{
  weak var viewController: MobileListViewController?
  var dataStore: MobileListDataStore?
  
  // MARK: Routing
  
  func routeToMobileDetail(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! MobileDetailViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToMobileDetail(source: dataStore!, destination: &destinationDS)
    }
  }

  // MARK: Passing data
  
  func passDataToMobileDetail(source: MobileListDataStore, destination: inout MobileDetailDataStore)
  {
    guard let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row,
      let fetchMobileViewModel = viewController?.fetchMobilesViewModel else { return }
    let displayedMobile = fetchMobileViewModel.displayedMobiles[selectedRow]
    let mobile: Mobile?
    switch fetchMobileViewModel.displayMethod.type {
    case .all:
      mobile = source.mobiles?.first { $0.id == displayedMobile.id }
    default:
      mobile = source.favouriteMobiles?.first { $0.id == displayedMobile.id }
    }
    destination.mobile = mobile
  }

}