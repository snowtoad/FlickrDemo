//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by apple on 2020/5/27.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: String?
    @NSManaged public var farm: Int64
    @NSManaged public var isfamily: Int64
    @NSManaged public var ispublic: Int64
    @NSManaged public var owner: String?
    @NSManaged public var secret: String?
    @NSManaged public var server: String?
    @NSManaged public var title: String?
    @NSManaged public var isfriend: Int64

}
