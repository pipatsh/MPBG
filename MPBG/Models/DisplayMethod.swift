//
//  DisplayMethod.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

struct DisplayMethod
{
    enum DisplayType: Int {
        case all = 0
        case favourite = 1

    }
    
    var type: DisplayType
    
    var stringValue: String {
        switch type {
        case .all:
            return "All"
        case .favourite:
            return "Favourite"
        }
    }
}
