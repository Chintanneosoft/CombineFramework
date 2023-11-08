//
//  SubjectPublisher.swift
//  CombineFramework
//
//  Created by Neosoft on 08/11/23.
//

import SwiftUI

struct SubjectPublisher: View {
    
    @StateObject var dataModel = DataModel()
    
    var body: some View {
        VStack{
            NavigationLink("Sender View", destination: SenderView(dataModel: dataModel))
                .foregroundColor(Color.pink)
                .padding(15)
                .background(.black)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .cornerRadius(10)
            
            NavigationLink("Receiver View", destination: ReceiverView(dataModel: dataModel))
                .foregroundColor(Color.pink)
                .padding(15)
                .background(.black)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .cornerRadius(10)
        }
    }
}

struct SubjectPublisher_Previews: PreviewProvider {
    static var previews: some View {
        SubjectPublisher()
    }
}
