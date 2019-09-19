//
//  Barang+CoreDataProperties.swift
//  nanoChallenge2
//
//  Created by Golden Kevin on 19/09/19.
//  Copyright © 2019 Golden Kevin. All rights reserved.
//
//

import Foundation
import CoreData


extension Barang {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Barang> {
        return NSFetchRequest<Barang>(entityName: "Barang")
    }

    @NSManaged public var namabarang: String?

}
