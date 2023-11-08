//
//  ProductListViewModel.swift
//  02_APICall_MVVM
//
//  Created by webwerks  on 07/11/23.
//

import Foundation
import Combine

class ProductListViewModel: ObservableObject {
    
    @Published var products: [ProductListDetails] = []
    @Published var isPresentingAlert = false
    @Published var backendMessage = ""
    @Published var isNavigating = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func getDataFromViewModel() {
        ProductListingService.productList()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isPresentingAlert = true
                    self.backendMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] (productList, invalidCategoryId, dataMissing, wrongMethod) in
                guard let self = self else { return }
                if let productList = productList {
                    self.products = productList.data ?? []
                    self.isPresentingAlert = false
                    self.isNavigating = true
                } else if let invalidCategoryId = invalidCategoryId {
                    self.isPresentingAlert = true
                    self.backendMessage = invalidCategoryId.user_msg ?? ""
                } else if let dataMissing = dataMissing {
                    self.isPresentingAlert = true
                    self.backendMessage = dataMissing.user_msg ?? ""
                } else if let wrongMethod = wrongMethod {
                    self.isPresentingAlert = true
                    self.backendMessage = wrongMethod.user_msg ?? ""
                }
            })
            .store(in: &cancellables)
    }
}
