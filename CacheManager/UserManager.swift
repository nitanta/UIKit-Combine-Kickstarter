//
//  UserManager.swift
//  Book share
//
//  Created by Nitanta Adhikari on 4/16/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Moya
import Firebase
import SwiftyJSON

class UserManager {
    
    static let sharedInstance: UserManager = UserManager()
    var currentUser: BehaviorRelay<User?> = BehaviorRelay(value:nil)
    var currentSeller: BehaviorRelay<Seller?> = BehaviorRelay(value:nil)
    var currentToken: BehaviorRelay<String?> = BehaviorRelay(value:nil)
    var currentUserId: BehaviorRelay<Int?> = BehaviorRelay(value:nil)
    var showKeyChainWrapper: BehaviorRelay<Bool> = BehaviorRelay(value:false)
    private init(){
        guard let user = UserDefaults.standard.value(forKey: UserDefaultsKey.CurrentUser) as? String else{return}
        guard let userId = UserDefaults.standard.value(forKey: UserDefaultsKey.SellerInfo) as? Int else{return}
        guard let seller = UserDefaults.standard.value(forKey: UserDefaultsKey.CurrentSeller) as? String else{return}
        let json = JSON.init(parseJSON: user)
        let sellerjson = JSON.init(parseJSON: seller)
        currentUser.accept(User(json))
        currentUserId.accept(userId)
        currentSeller.accept(Seller(sellerjson))
        
        guard let tokenString = UserDefaults.standard.value(forKey: UserDefaultsKey.AuthorizationToken) as? String else{return}
        currentToken.accept( tokenString)
    }
    
    func isLoggedIn() -> Bool {
        guard let token = currentToken.value else { return false }
        return !token.isEmpty
    }
    
    func updateCurrentUser(json: JSON){
        UserDefaults.standard.setValue(json.rawString()!, forKey: UserDefaultsKey.CurrentUser)
        currentUser.accept(User(json))
    }
    
    func updateSellerUserInfo(json: JSON){
        UserDefaults.standard.setValue(json.rawString()!, forKey: UserDefaultsKey.CurrentSeller)
        currentSeller.accept(Seller(json))
    }
    
    func updateCurrentUserId(value: Int){
        UserDefaults.standard.setValue(value, forKey: UserDefaultsKey.SellerInfo)
        currentUserId.accept(value)
    }
    
    
    func updateAuthorizationToken(token: String){
        UserDefaults.standard.setValue(token, forKey: UserDefaultsKey.AuthorizationToken)
        currentToken.accept(token)
    }
    
    func deleteUserDaa(){
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.CurrentUser)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.SellerInfo)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.CurrentSeller)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.AuthorizationToken)
        self.currentUserId.accept(nil)
        self.currentUser.accept(nil)
        self.currentToken.accept(nil)
        self.currentSeller.accept(nil)
    }
    
    func registerPushNotification(){
        let provider = MoyaProvider<Api>()
        InstanceID.instanceID().instanceID { (result, error) in
            if let result = result{
                provider.request(.registerDevice(token: result.token)) { (result) in
                    switch result {
                    case .success(let val):
                        break
                    case .failure(_):
                        self.registerPushNotification()
                        break
                    }
                }
            }
        }
    }
    
    func unregisterPushNotification(){
        let provider = MoyaProvider<Api>()
        InstanceID.instanceID().instanceID { (result, error) in
            if let result = result{
                provider.request(.unregisterDevice(token: result.token)) { (result) in
                    switch result {
                    case .success(let val):
                        break
                    case .failure(_):
                        self.unregisterPushNotification()
                        break
                    }
                }
            }
        }
    }
    
}
