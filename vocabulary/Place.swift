//
//  Place.swift
//  vocabulary
//
//  Created by Elina on 12/5/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import Foundation
import CoreData

public class Place: NSManagedObject {
    @NSManaged var longitude: Double
    @NSManaged var latitude: Double
}
