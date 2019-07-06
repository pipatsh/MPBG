//
//  SortMethod.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

struct SortMethod
{
    enum SortType: Int {
        case priceLowToHigh = 0
        case priceHighToLow = 1
        case rating = 2
    }
    
    var type: SortType
    
    var stringValue: String {
        switch type {
        case .priceLowToHigh:
            return "Price low to high"
        case .priceHighToLow:
            return "Price high to low"
        case .rating:
            return "Rating"
        }
    }
}
