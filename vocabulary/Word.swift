//
//  Word.swift
//  vocabulary
//
//  Created by Elina on 12/2/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import Foundation
import CoreData

class Word {
    var id: String
    var word: String
    var definition: String
    var image: String
    
    init(id: String, word: String, definition: String, image: String) {
        self.id = id
        self.word = word
        self.definition = definition
        self.image = image
    }
}
