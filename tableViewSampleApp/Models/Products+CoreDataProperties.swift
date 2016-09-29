//
//  Products+CoreDataProperties.swift
//  tableViewSampleApp
//
//  Created by webonise on 29/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Products {

    @NSManaged var productCategory: String?
    @NSManaged var productName: String?
    @NSManaged var productPrice: String?

}
