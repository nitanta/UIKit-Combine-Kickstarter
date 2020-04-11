//
//  UICollectionViewExtension.swift
//  Book share
//
//  Created by Nitanta on 11/16/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func addEmptyView(text: String = "Sorry there is nothing to show here.") {
        removeEmptyView()
        let emptyView = UILabel()
        emptyView.tag = 222
        self.addSubview(emptyView)
        emptyView.center = self.center
    }
    
    func removeEmptyView() {
        for item in self.subviews {
            if item.tag == 222 {
                item.removeFromSuperview()
            }
        }
    }
}
