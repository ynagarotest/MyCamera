//
//  UIImageExtension.swift
//  MyCamera
//
//  Created by Yasuo Nagaro on 2025/06/27.
//

import Foundation
import UIKit

extension UIImage {
    func resized() -> UIImage?{
        let rate = 1024.0 / self.size.width
        let targetSize = CGSize(width: self.size.width * rate, height: self.size.height * rate)
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
