//
//  UIImageView+Network.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

// Должен существовать глобально всю жизнь приложения
private let cache = Cache<String, UIImage>()

extension UIImageView {
	func setImage(with url: URL) {
		DispatchQueue.global(qos: .background).async {
			if let image = cache.object(forKey: url.absoluteString) {
				DispatchQueue.main.async { [weak self] in
					self?.image = image
				}
			} else {
				do {
					let imageData = try Data(contentsOf: url)
					
					guard let image = UIImage(data: imageData) else { return }
					
					cache.setObject(image, forKey: url.absoluteString)
					
					DispatchQueue.main.async { [weak self] in
						self?.image = image
					}
				} catch {
					return
				}
			}
		}
	}
}

private class Cache<Key, Value> where Key: Any, Value: Any {
    let cache = NSCache<AnyObject, AnyObject>()
    
    func object(forKey key: Key) -> Value? {
        return cache.object(forKey: key as AnyObject) as? Value
    }
    
    func setObject(_ object: Value, forKey key: Key) {
        cache.setObject(object as AnyObject, forKey: key as AnyObject)
    }
}
