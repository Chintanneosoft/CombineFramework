//
//  ContentView.swift
//  CombineFramework
//
//  Created by Neosoft on 07/11/23.
//

import SwiftUI
struct ContentView: View {
    
    @ObservedObject var viewModel = ProductListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ProductListView(), isActive: $viewModel.isNavigating) {
                    Button(action: {
                        viewModel.getDataFromViewModel() {
                            (success, invalidId, dataMissing, wrongMethod, error) in
                            if success != nil {
                                DispatchQueue.main.async {
                                    viewModel.isNavigating = true
                                }
                            }
                            else {
                            }
                        }
                    }) {
                        Text("API CALL")
                            .foregroundColor(Color.pink)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(10)
                            .frame(width: 130)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                }
                .padding()
                
                PublisherSubscriberView()
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
