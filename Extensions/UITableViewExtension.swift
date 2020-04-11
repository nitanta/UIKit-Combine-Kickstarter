//
//  UITableViewExtension.swift
//  Book share
//
//  Created by Nitanta on 11/16/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation
import UIKit

protocol NibProvidable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibProvidable {
    static var nibName: String {
        return "\(self)"
    }
    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
}

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

// Cell
extension UITableView {
    func registerClass<T: UITableViewCell>(cellClass `class`: T.Type) where T: ReusableView {
        register(`class`, forCellReuseIdentifier: `class`.reuseIdentifier)
    }

    func registerNib<T: UITableViewCell>(cellClass `class`: T.Type) where T: NibProvidable & ReusableView {
        register(`class`.nib, forCellReuseIdentifier: `class`.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(withClass `class`: T.Type) -> T? where T: ReusableView {
        return self.dequeueReusableCell(withIdentifier: `class`.reuseIdentifier) as? T
    }

    func dequeueReusableCell<T: UITableViewCell>(withClass `class`: T.Type, forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: `class`.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error: cell with identifier: \(`class`.reuseIdentifier) for index path: \(indexPath) is not \(T.self)")
        }
        return cell
    }
}


extension UITableView {
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
