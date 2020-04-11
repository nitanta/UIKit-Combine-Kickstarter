//
//  UIImageExtension.swift
//  yayos
//
//  Created by Aatish Rajkarnikar on 9/6/18.
//  Copyright © 2018 Aatish Rajkarnikar. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func scale(scaledToSize newSize:CGSize) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
        
    }
    
    func fixOrientation() -> UIImage? {
        
        guard let cgImage = self.cgImage else {
            return nil
        }
        
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        let width  = self.size.width
        let height = self.size.height
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: width, y: height)
            transform = transform.rotated(by: CGFloat.pi)
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.rotated(by: 0.5*CGFloat.pi)
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: height)
            transform = transform.rotated(by: -0.5*CGFloat.pi)
            
        case .up, .upMirrored:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        default:
            break;
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        guard let colorSpace = cgImage.colorSpace else {
            return nil
        }
        
        guard let context = CGContext(
            data: nil,
            width: Int(width),
            height: Int(height),
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: UInt32(cgImage.bitmapInfo.rawValue)
            ) else {
                return nil
        }
        
        context.concatenate(transform);
        
        switch self.imageOrientation {
            
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: height, height: width))
            
        default:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        
        // And now we just create a new UIImage from the drawing context
        guard let newCGImg = context.makeImage() else {
            return nil
        }
        
        let img = UIImage(cgImage: newCGImg)
        
        return img;
    }
    
    
    
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(self.cgImage!, in: newRect)
            let newImage = UIImage(cgImage: context.makeImage()!)
            UIGraphicsEndImageContext()
            return newImage
        }
        return nil
    }
}

    
    
    

