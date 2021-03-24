//
//  UIImage.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 24/03/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /// Allow download images from web.
    /// - Note: Only HTTPS request are allowed
    /// - Parameter urlString: String with the url image.
    func imageFromURL(_ urlString: String?, contenMode: ContentMode = .scaleAspectFill) {
        
        guard let url = URL(string: urlString ?? "") else {
            return
        }
        
        image = nil
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = cachedImage
            return
        }
        
        let loadImageIndicator: UIActivityIndicatorView!
        loadImageIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        loadImageIndicator.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        loadImageIndicator.startAnimating()
        self.addSubview(loadImageIndicator)
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] (data, _, error) in
            guard error == nil,
                let data = data,
                let weakSelf = self else {
                    DispatchQueue.main.async {
                        self?.contentMode = contenMode
                        self?.image = #imageLiteral(resourceName: "logo")
                        loadImageIndicator.removeFromSuperview()
                    }
                return
            }
            DispatchQueue.main.async {
                let downloadedImage = UIImage(data: data)
                weakSelf.contentMode = contenMode
                imageCache.setObject(downloadedImage as AnyObject, forKey: url.absoluteString as AnyObject)
                weakSelf.image = downloadedImage
                loadImageIndicator.removeFromSuperview()
            }
        }.resume()
    }
}
