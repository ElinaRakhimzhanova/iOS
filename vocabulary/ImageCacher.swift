//
//  ImageCacher.swift
//  vocabulary
//
//  Created by Elina on 12/5/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import Foundation
import UIKit

class ImageCacher {
    
    let imageCache = NSCache<NSString, UIImage>()
    static var shared = ImageCacher()

    private init() {}

}
