//
//  ContentView.swift
//  CombineFramework
//
//  Created by Neosoft on 07/11/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var viewModel = ProductListViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                NavigationLink(destination: ProductListView(), isActive: $viewModel.isNavigating) {
                    Button(action: {
                    viewModel.getDataFromViewModel()
                    }) {
                        Text("API CALL")
                            .foregroundColor(Color.red)
                            .padding(15)
                            .background(.black)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                NavigationLink(destination: PublisherSubscriberView()){
                        Text("Publisher Subscriber View")
                            .foregroundColor(Color.red)
                            .padding(15)
                            .background(.black)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .cornerRadius(10)
                }
                .padding()
                
                NavigationLink(destination: SubjectPublisher()){
                        Text("Subject Publisher")
                            .foregroundColor(Color.red)
                            .padding(15)
                            .background(.black)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .cornerRadius(10)
                }
                .padding()
                
                NavigationLink(destination: SchedulerView()){
                        Text("Scheduler")
                            .foregroundColor(Color.red)
                            .padding(15)
                            .background(.black)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .cornerRadius(10)
                }
                .padding()
            }
        }
        .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
