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
    
    var justPublisherr : Just<Int>?
    
    var arrayPublisher = [1,2,3].publisher
    
    func justAcross(){
        justPublisherr = Just(num)
    }

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
    @State var arrayCancellable: Cancellable?
    @State var justCancellable: Cancellable?
    
    @State var resText = "Normal Just Publisher"
    @State var pubText = "Publisher Array"
    @State var val = 0
    @State var ps5 = ""
    
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
                    .foregroundColor(Color.red)
                    .padding(15)
                    .background(.black)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .cornerRadius(10)
            }
            
            HStack{
                Button {
                    subScribeArrayPublisher()
                } label: {
                    Text("Subscribe to Array Publisher")
                        .foregroundColor(Color.orange)
                        .padding(15)
                        .background(.black)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    ps.arrayPublisher = ps.arrayPublisher.append(4)
                }) {
                    Text("Update Array: \(pubText)")
                        .foregroundColor(Color.orange)
                        .padding(15)
                        .background(.black)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
            }

            HStack{
                Button(action: {
                    subScribeJustPublisher()
                }) {
                    Text("Subscribe Just Subscriber")
                        .foregroundColor(Color.cyan)
                        .padding(15)
                        .background(.black)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    ps.num += 1
                }) {
                    Text("Update Just num:\(ps5)")
                        .foregroundColor(Color.cyan)
                        .padding(15)
                        .background(.black)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
                
                Button(action: {
                   publishJustPublisher()
                }) {
                    Text("Publish Just Publisher")
                        .foregroundColor(Color.cyan)
                        .padding(15)
                        .background(.black)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
    
    func subScribeArrayPublisher(){
        arrayCancellable = ps.arrayPublisher.print().sink(receiveCompletion: { completion in
        }) { value in
            print("Received array val: \(value)")
            self.pubText = "\(ps.arrayPublisher.sequence)"
        }
    }
    
    func subScribeJustPublisher(){
        justCancellable = ps.justPublisherr?.print().sink(receiveCompletion: { completion in
        }) { value in
            print("Received array val: \(value)")
            ps5 = "\(ps.num)"
        }
    }
    
    func publishJustPublisher(){
        ps.justAcross()
    }
}
