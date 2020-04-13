//
//  ListViewModelImplementation.swift
//  KickStarter
//
//  Created by ebpearls on 4/11/20.
//  Copyright © 2020 ebpearls. All rights reserved.
//

import Foundation
import Combine

class ListViewModelImplementation: ViewModelImplementation, ListViewModel {
    var callApi: PassthroughSubject<Void, APIError> = PassthroughSubject<Void, APIError>()
    var albums: CurrentValueSubject<[Album], Never> = CurrentValueSubject([])
    
    override init() {
        super.init()
        callApiObserver()
    }
    
    func callApiObserver() {
        let callrequest = callApi.handleEvents { (_) in
            self.isLoading.send(true)
        }.flatMap {_ in
            return APIService.sharedAPIService.request(route: .albums).eraseToAnyPublisher().mapError { $0 }
        }.handleEvents(receiveRequest: { (_) in
            self.isLoading.send(false)
        }).share()
        
        callrequest.sink(receiveCompletion: { (data) in
            switch data {
            case .failure(let error):
                let alert = AlertViewModelImplementation(topTap: nil, bottomTap: nil)
                alert.topText.send("TRY AGAIN")
                alert.bottomText.send("OKAY")
                alert.text.send(error.localizedDescription)
                self.alertViewModel.send(alert)
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            let albums = try! JSONDecoder().decode([Album].self, from: response.result)
            self.albums.send(albums)
        }).store(in: &bag)
        
    }
}
