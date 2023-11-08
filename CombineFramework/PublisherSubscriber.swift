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
    
    var num = 0
    
    func addTwoNumbers(a:Int,b:Int) -> Int{
        print("num = ",a)
        return a + b
    }
    
    public func publisherSubsriber() -> AnyPublisher<Int,Never> {
        // Creating Publisher
        let justPublisher = Just(addTwoNumbers(a: num, b: 5))
        
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
    @State var val = 0
    
    var body: some View {
        VStack{
            Button(action: {
                let resultPublisher = ps.publisherSubsriber()
                let cancellable = resultPublisher.sink(receiveCompletion: { completion in
                }) { value in
                    print("Received value: \(value)")
                    resText = " Received Value: \(value)"
                    val += 1
                    ps.num = val
                }
            }) {
                Text(resText)
                    .foregroundColor(Color.cyan)
                    .padding(15)
                    .background(.black)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .cornerRadius(10)
            }
            
        }
    }
}
