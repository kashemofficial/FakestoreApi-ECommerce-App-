//
//  Product+CoreDataProperties.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 3/2/23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var url: String?
    @NSManaged public var itemTitle: String?
    @NSManaged public var id: NSDecimalNumber?

}

extension Product : Identifiable {

}
