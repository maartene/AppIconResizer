//
//  Resizer.swift
//  AppIcon Resizer CLI
//
//  Created by Maarten Engels on 24/09/2019.
//  Copyright © 2019 thedreamweb. All rights reserved.
//

import Foundation
import Cocoa

struct Resizer {
    
    
    
    static let SIZES = [CGSize(width: 40, height: 40), CGSize(width: 80, height: 80), CGSize(width: 60, height: 60),
                        CGSize(width: 58, height: 58), CGSize(width: 87, height: 87), CGSize(width: 120, height: 120),
                        CGSize(width: 180, height: 180), CGSize(width: 20, height: 20), CGSize(width: 29, height: 29),
                        CGSize(width: 76, height: 76), CGSize(width: 152, height: 152), CGSize(width: 167, height: 167),
                        CGSize(width: 1024, height: 1024)]
    
    static func resizeImage(_ image: CGImage) -> [CGImage] {
        
        
        var result = [CGImage]()
        
        for size in Self.SIZES {
            result.append(image.resizeImage(targetSize: size))
        }
        
        return result
    }
    
}

extension CGImage {
  func resizeImage(targetSize: CGSize) -> CGImage {
    let size = CGSize(width: self.width, height: self.height)
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    let context = CGContext(data: nil, width: Int(newSize.width), height: Int(newSize.height), bitsPerComponent: self.bitsPerComponent, bytesPerRow: self.bytesPerRow, space: self.colorSpace ?? CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
    context?.draw(self, in: rect)
    
    
    return context!.makeImage()!
  }
}
