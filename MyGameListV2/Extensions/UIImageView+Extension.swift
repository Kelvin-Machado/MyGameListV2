//
//  UIImageView+Extension.swift
//  MyGameListV2
//
//  Created by Kelvin Batista Machado on 20/02/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(from urlString: String,
                  placeholder: UIImage? = nil,
                  fadeDuration: TimeInterval = 0.1,
                  forceRefresh: Bool = false,
                  shouldCacheMemory: Bool = true,
                  shouldCacheDisk: Bool = true,
                  completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }
        
        var options: KingfisherOptionsInfo = [.transition(.fade(fadeDuration))]
        
        if !shouldCacheMemory {
            options.append(.memoryCacheExpiration(.never))
        }
        
        if !shouldCacheDisk {
            options.append(.diskCacheExpiration(.never))
        }
        
        if forceRefresh {
            options.append(.forceRefresh)
        }
        
        let cache = ImageCache.default
        
        cache.diskStorage.config.sizeLimit = UInt(100 * 1024 * 1024)
        
        kf.setImage(with: url,
                    placeholder: placeholder,
                    options: options,
                    completionHandler: completionHandler)
    }
}
