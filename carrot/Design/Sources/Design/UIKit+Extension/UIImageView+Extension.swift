//
//  UIImageView+Extension.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import UIKit

public extension UIImageView {
    
    func loadImage(from url: URL) {
        if let cachedImage = CacheManager.shared.loadImage(from: url) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                
                CacheManager.shared.saveImage(image, for: url)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.image = image
                }
            }.resume()
        }
    }
    
    func loadImage(from link: String) {
        guard let url = URL(string: link) else { return }
        loadImage(from: url)
    }
}
