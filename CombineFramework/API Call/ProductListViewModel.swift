//
//  ProductListViewModel.swift
//  CombineFramework
//
//  Created by Neosoft on 07/11/23.
//
import Foundation

class ProductListViewModel: ObservableObject {
    
    @Published var products: [ProductListDetails] = []
    @Published var isPresentingAlert = false
    @Published var backendMessage = ""
    @Published var isNavigating = false
    
    func getDataFromViewModel(completion: @escaping (ProductListResponse?, ProductListInvalidCategoryId?, ProductListDataMissing?, ProductListWrongMethod?, Error?) -> (Void)) {
        
        ProductListingService.productList() {
            (success, invalidategoryId, dataMissing, wrongMethod, error) in
            if let value = success {
                completion(value, nil, nil, nil, nil)
                DispatchQueue.main.async {
                    self.products += value.data ?? []
                    self.isPresentingAlert = false
                }
            }
            else if let data = invalidategoryId {
                completion(nil, data, nil, nil, nil)
                DispatchQueue.main.async {
                    self.isPresentingAlert = true
                    self.backendMessage = data.user_msg ?? ""
                }
            }
            else if let data = dataMissing {
                completion(nil, nil, data, nil, nil)
                DispatchQueue.main.async {
                    self.isPresentingAlert = true
                    self.backendMessage = data.user_msg ?? ""
                }
            }
            else if let data = wrongMethod {
                completion(nil, nil, nil, data, nil)
                DispatchQueue.main.async {
                    self.isPresentingAlert = true
                    self.backendMessage = data.user_msg ?? ""
                }
            }
            else {
                completion(nil, nil, nil, nil, error)
                DispatchQueue.main.async {
                    self.isPresentingAlert = true
                }
            }
        }
    }
}
