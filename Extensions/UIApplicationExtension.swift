//
//  UIApplicationExtension.swift
//  yayos
//
//  Created by Nitanta Adhikari on 10/26/18.
//  Copyright © 2018 Aatish Rajkarnikar. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension UIApplication{
    var handleBadge: Void{
        UIApplication.shared.applicationIconBadgeNumber += 1
    }
    
    var clearBadge: Void{
        if #available(iOS 10.0, *) {
            self.applicationIconBadgeNumber = 0
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            center.removeAllDeliveredNotifications()
        } else {
            self.applicationIconBadgeNumber = 0
            UIApplication.shared.cancelAllLocalNotifications()
        }
    }
}
