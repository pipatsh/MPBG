//
//  DataError.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 4/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

enum DataError: Error {
  case cannotFetch(String)
  case cannotAdd(String)
  case cannotDelete(String)
  case unknownReason
  
  var reason: String {
    switch self {
    case .cannotFetch(_):
      return "Can not fetch"
    case .cannotAdd(_):
      return "Can not add"
    case .cannotDelete(_):
      return "Can not delete"
    default:
      return "Unknown reason"
    }
  }
}
