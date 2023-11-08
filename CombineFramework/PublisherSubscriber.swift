//
//  PublisherSubscriber.swift
//  CombineFramework
//
//  Created by Neosoft on 07/11/23.
//

import Foundation
import Combine
import SwiftUI

class PubliserSubscriber{
    
    func addTwoNumbers(a:Int,b:Int) -> Int{
        return a + b
    }
    
    public func publisherSubsriber() -> AnyPublisher<Int,Never> {
        // Creating Publisher
        let justPublisher = Just(addTwoNumbers(a: 3, b: 5))
        
        // Creating Subscriber
        let justSubscriber = Subscribers.Sink<Int, Never> { completion in
            print(completion)
        } receiveValue: { valueFromPublisher in
            print(valueFromPublisher)
        }
        justPublisher.print().subscribe(justSubscriber)
        return justPublisher.eraseToAnyPublisher()
    }
}

struct PublisherSubscriberView: View {
    
    let ps = PubliserSubscriber()
    @State var resText = "Normal Just Publisher"
    
    var body: some View {
        Text(resText)
            .onTapGesture {
                let resultPublisher = ps.publisherSubsriber()
                let cancellable = resultPublisher.sink(receiveCompletion: { completion in
                }) { value in
                    print("Received value: \(value)")
                    resText = " Received Value: \(value)"
                }
            }
    }
}
