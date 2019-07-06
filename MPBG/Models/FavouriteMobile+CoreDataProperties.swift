//
//  FavouriteMobile+CoreDataProperties.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//
//

import Foundation
import CoreData


extension FavouriteMobile
{
    @NSManaged public var id: Int64
    @NSManaged public var price: Double
    @NSManaged public var rating: Double
    @NSManaged public var name: String?
    @NSManaged public var brand: String?
    @NSManaged public var thumbImageURL: String?
    @NSManaged public var desc: String?

}
