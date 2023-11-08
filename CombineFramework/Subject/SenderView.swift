//
//  SenderView.swift
//  CombineFramework
//
//  Created by Neosoft on 08/11/23.
//

import Foundation
import SwiftUI
import Combine

struct SenderView: View {
    @ObservedObject var dataModel: DataModel

    var body: some View {
        VStack {
            TextField("Enter a message", text: $dataModel.message)
                .padding()
            Button("Publish using PassthroughSubject") {
                dataModel.passThroughSubject.send(dataModel.message)
            }
            Button("Publish using CurrentValueSubject") {
                dataModel.currentValueSubject.send(dataModel.message)
            }
            
        }
    }
}
