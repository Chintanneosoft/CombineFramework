//
//  ProductListServices.swift
//  CombineFramework
//
//  Created by Neosoft on 07/11/23.
//

import Foundation

class ProductListingService {
    
    static func productList(completion: @escaping (ProductListResponse?, ProductListInvalidCategoryId?, ProductListDataMissing?, ProductListWrongMethod?, Error?) -> (Void)) {
        
        APIManager.sharedInstance.makeApiCall(serviceType: .getProductList) {
            response in
            switch response {
            case .success(let value):
                if let content = value as? Data {
                    do {
                        let responseData = try JSONDecoder().decode(ProductListResponse.self, from: content)
                        if responseData.status == 200 {
                            completion(responseData, nil, nil, nil, nil)
                        }
                        else if responseData.status == 401 {
                            let invalidData = try JSONDecoder().decode(ProductListInvalidCategoryId.self, from: content)
                            completion(nil, invalidData, nil, nil, nil)
                        }
                        else if responseData.status == 400 {
                            let dataMissing = try JSONDecoder().decode(ProductListDataMissing.self, from: content)
                            completion(nil, nil, dataMissing, nil, nil)
                        }
                        else {
                            let wrongMethod = try JSONDecoder().decode(ProductListWrongMethod.self, from: content)
                            completion(nil, nil, nil, wrongMethod, nil)
                        }
                    }
                    catch {
                        completion(nil, nil, nil, nil, value as? Error)
                    }
                }
            case .failure(let error):
                completion(nil, nil, nil, nil, error)
            }
        }
    }
}
