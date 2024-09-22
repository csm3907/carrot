//
//  ImageCacheManager.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import UIKit

enum Cache {
    case memory
    case file
}

class CacheManager {
    static let shared = CacheManager(config: .file)
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    
    private let config: Cache
    private init(config: Cache) {
        self.config = config
    }
    
    func loadImage(from url: URL) -> UIImage? {
        if config == .memory {
            return loadMemoryImage(from: url)
        } else {
            return loadImageFromFileCache(url: url)
        }
    }
    
    func saveImage(_ image: UIImage, for url: URL) {
        if config == .memory {
            saveImageToFileCache(image: image, url: url)
        } else {
            saveImageToMomoryImage(image, for: url)
        }
    }
    
    private func loadMemoryImage(from url: URL) -> UIImage? {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
        return loadImageFromFileCache(url: url)
    }
    
    private func saveImageToMomoryImage(_ image: UIImage, for url: URL) {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
        saveImageToFileCache(image: image, url: url)
    }
    
    private func loadImageFromFileCache(url: URL) -> UIImage? {
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let filePath = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        
        return UIImage(contentsOfFile: filePath.path)
    }
    
    private func saveImageToFileCache(image: UIImage, url: URL) {
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let filePath = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        
        if let data = image.pngData() {
            try? data.write(to: filePath)
        }
    }
}
