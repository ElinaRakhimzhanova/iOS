//
//  WordManager.swift
//  vocabulary
//
//  Created by Elina on 12/2/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol WordDelegate: class {
    func downloadWords(words: [Word])
}

class WordManager {
    
    private lazy var databaseReference = Database.database().reference()
    private var refHandle: DatabaseHandle!
    static var shared = WordManager()
    var delegate: WordDelegate?
    var vocabulary: [Word] = []
    
    init() {
        self.refHandle = self.databaseReference.observe(DataEventType.value) { (snapshot) in
            
            for words in snapshot.children.allObjects as! [DataSnapshot]{
                let wordObject = words.value as? [String: AnyObject]
                let wordId = wordObject?["id"]
                let wordName = wordObject?["word"]
                let wordDefinition = wordObject?["definition"]
                let wordImage = wordObject?["image"]
            
                let word = Word(id: wordId as! String, word: wordName as! String, definition: wordDefinition as! String, image: wordImage as! String)
            
                self.vocabulary.append(word)
            }
            self.delegate?.downloadWords(words: self.vocabulary)
        
        }
    }
    
}
