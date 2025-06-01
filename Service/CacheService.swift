//
//  CacheService.swift
//  PDFReportGenerator-UIKit
//
//  Created by Adarsh on 31/05/25.
//

import Foundation

class CacheService {
    static let shared = CacheService()

    private var cachedData = NSCache<NSString, NSArray>()

    private init() { }

    func save<T>(_ objects: [T], forKey key: String) {
        let nsKey = key as NSString
        let nsArray = objects as NSArray
        cachedData.setObject(nsArray, forKey: nsKey)
    }

    func get<T>(forKey key: String) -> [T]? {
        let nsKey = key as NSString
        if let nsArray = cachedData.object(forKey: nsKey) as? [Any] {
            return nsArray as? [T]
        }
        return nil
    }
}
