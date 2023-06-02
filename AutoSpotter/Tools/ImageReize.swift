//
//  ImageReize.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-01.
//

import Foundation
import UIKit

extension UIImage{
    func resize(size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizeImage
    }
}
