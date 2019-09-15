//
//  Extension+UIImageView.swift
//  Simple
//
//  Created by Weslie on 2018/11/6.
//  Copyright © 2018 Weslie. All rights reserved.
//

import UIKit

extension UIImageView {
	/**
	Download an image from url
	- parameters:
	- url: image url
	- mode: image fill mode
	*/
	func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
		contentMode = mode
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async() {
				self.image = image
			}
		}.resume()
	}
}

extension UIImage {
	
	func resized() -> UIImage {
		let ratio: CGFloat = 1.6
		let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
		UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
		draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage!
	}
}
