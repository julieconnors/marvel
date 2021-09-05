//
//  ImageCache.swift
//  Marvel
//
//  Created by Julie Connors on 9/4/21.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    private init() {}
    
    var cache: NSCache<NSString, UIImage> = NSCache()
    
    func findImage(string: String) -> UIImage? {
        let nsImageString = string as NSString
        return cache.object(forKey: nsImageString)
    }
    
    func addImage(string: String, image: UIImage) {
        let nsImageString = string as NSString
        cache.setObject(image, forKey: nsImageString)
    }
}
