//
//  ReceiverView.swift
//  CombineFramework
//
//  Created by Neosoft on 08/11/23.
//

import Foundation
import SwiftUI
import Combine

struct ReceiverView: View {
    @ObservedObject var dataModel: DataModel
    @State var pass : String = ""
    @State var curr : String = ""
    var body: some View {
        VStack {
            Text("Received message: \(dataModel.message)")
                .background(.red)
            Text("Received from CurrentValueSubject: ")
                .background(.green)
                .onReceive(dataModel.currentValueSubject) { message in
                    curr = "curr " + message
                    print(curr)
                }
            Text(curr)
                .background(.red)
            
            Text("Received from PassthroughSubject: ")
                .background(.green)
                .onReceive(dataModel.passThroughSubject) { message in
                    pass = "pass " + message
                    print(pass)
                }
            Text(pass)
                .background(.red)
        }
    }
}
