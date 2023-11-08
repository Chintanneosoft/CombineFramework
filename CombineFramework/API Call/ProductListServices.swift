//
//  ProductListingService.swift
//  02_APICall_MVVM
//
//  Created by webwerks  on 07/11/23.
//

import Foundation
import Combine

class ProductListingService {
    
    static func productList() -> AnyPublisher<(ProductListResponse?, ProductListInvalidCategoryId?, ProductListDataMissing?, ProductListWrongMethod?), Error> {
        
        return APIManager.sharedInstance.makeApiCall(serviceType: .getProductList)
            .tryMap { data in
                do {
                    let responseData = try JSONDecoder().decode(ProductListResponse.self, from: data)
                    if responseData.status == 200 {
                        return (responseData, nil, nil, nil)
                    } else if responseData.status == 401 {
                        let invalidData = try JSONDecoder().decode(ProductListInvalidCategoryId.self, from: data)
                        return (nil, invalidData, nil, nil)
                    } else if responseData.status == 400 {
                        let dataMissing = try JSONDecoder().decode(ProductListDataMissing.self, from: data)
                        return (nil, nil, dataMissing, nil)
                    } else {
                        let wrongMethod = try JSONDecoder().decode(ProductListWrongMethod.self, from: data)
                        return (nil, nil, nil, wrongMethod)
                    }
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}
