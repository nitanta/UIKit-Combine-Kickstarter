//
//  UIViewExtension.swift
//  Book share
//
//  Created by Nitanta Adhikari on 3/31/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import UIKit

extension UIView {
    
    func rounded() {
        layer.cornerRadius = bounds.height / 2.0
        layer.masksToBounds = true
    }
    
    public func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    enum GradientStyle {
        case vertical
        case horizontal
        case diagonalLeftRightTopBottom
        case diagonalRightLeftTopBottom
    }
    
    func setCornerRadius(with corners: CACornerMask ) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.maskedCorners = corners
        //self.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func setCornerRadiusForSides(corners: CACornerMask) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.maskedCorners = corners
    }
    
    func setCornerRadius(fullyCornered: Bool = true, radius: CGFloat = 2.0) {
        layer.cornerRadius = fullyCornered ? frame.size.height / 2.0 : radius
        layer.masksToBounds = true
    }
    
    func applyBackgroundGradient(fromColor: CGColor, toColor: CGColor, style: GradientStyle) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [fromColor, toColor]
        gradientLayer.frame = self.bounds
        gradientLayer.frame.size.height = 600.0
        
        var startPoint = CGPoint.zero
        var endPoint = CGPoint.zero
        
        switch style {
        case .horizontal:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 1, y: 0)
            
        case .vertical:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: 1)
            
        case .diagonalLeftRightTopBottom:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 1, y: 1)
            
        case .diagonalRightLeftTopBottom:
            startPoint = CGPoint(x: 1, y: 0)
            endPoint = CGPoint(x: 0, y: 1)
        }
        
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        if let sublayers = self.layer.sublayers {
            _ = sublayers.map {
                if $0 is CAGradientLayer {
                    $0.removeFromSuperlayer()
                }
            }
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, cornerRadius: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func showBorderRing(borderWidth: CGFloat = 2, borderColor: UIColor = Color.primary) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat = 0, bottom: NSLayoutYAxisAnchor? = nil, paddingBottom: CGFloat = 0, left: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat = 0, right: NSLayoutXAxisAnchor? = nil, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func fillSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
       
    func fillSuperView(inset: UIEdgeInsets = .zero) {
        guard let superView = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset.left).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: inset.top).isActive = true
        superView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: inset.right).isActive = true
        superView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: inset.bottom).isActive = true
    }

    func constraintToSafeInset() {
        guard let superView = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        superView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func centerToSuperView(padding: CGFloat = 0.0) {
        guard let superView = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true

        setHorizontalConstraint(selfAnchor: leadingAnchor, otherAnchor: superView.leadingAnchor, constant: padding, priority: .defaultLow)
        setVerticalConstraint(selfAnchor: topAnchor, otherAnchor: superView.topAnchor, constant: padding, priority: .defaultLow)
    }

    func setHorizontalConstraint(selfAnchor: NSLayoutXAxisAnchor, otherAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = selfAnchor.constraint(equalTo: otherAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func setVerticalConstraint(selfAnchor: NSLayoutYAxisAnchor, otherAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = selfAnchor.constraint(equalTo: otherAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
    
    func setDimensionLayout(anchor: NSLayoutDimension, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func alignCenter(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func constraintSize(_ size: CGSize) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = true
    }
    
    func setMaxHeight(_ height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.heightAnchor.constraint(lessThanOrEqualToConstant: height)
        constraint.isActive = true
    }
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}

private let durationFadeAnimation: TimeInterval = 0.2
extension UIView {
    func animateFadeIn(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: durationFadeAnimation, delay: 0, options: [.beginFromCurrentState], animations: {
            self.alpha = 1
        }, completion: { _ in
            completion?()
        })
    }

    func animateFadeOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: durationFadeAnimation, delay: 0, options: [.beginFromCurrentState], animations: {
            self.alpha = 0
        }, completion: { _ in
            completion?()
        })
    }

    static func animateFadeOut(_ views: [UIView?], completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: durationFadeAnimation, animations: {
            views.forEach { $0?.alpha = 0 }
        }, completion: { _ in
            completion?()
        })
    }

    static func animateFadeIn(_ views: [UIView?], completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: durationFadeAnimation, animations: {
            views.forEach { $0?.alpha = 1 }
        }, completion: { _ in
            completion?()
        })
    }
}

