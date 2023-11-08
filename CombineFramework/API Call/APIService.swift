//
//  APIService.swift
//  02_APICall_MVVM
//
//  Created by webwerks  on 07/11/23.
//

import Foundation

let DEV_ROOT_POINT = "http://staging.php-dev.in:8844/trainingapp"
let PROD_ROOT_POINT = ""

enum NetworkEnvironment: String {
    case development
    case production
}

var networkEnvironment: NetworkEnvironment {
    return .development
}

var BaseURL: String {
    switch networkEnvironment {
    case .development :
        return DEV_ROOT_POINT
    case .production :
        return PROD_ROOT_POINT
    }
}

typealias stringAnyDict = [String: Any]
typealias stringStringDict = [String: String]
let contentKey = "Content-Type"
let contentValue = "application/x-www-form-urlencoded"

var pageNumber = 1

enum APIServices {
    case getProductList
    case getProductDetails(parameters: stringAnyDict)
}

extension APIServices {
    var Path: String {
        let apiDomain = "/api/"
        var servicePath: String = ""
        switch self {
        case .getProductList: servicePath = apiDomain + "products/getList?product_category_id=1&limit=10&page=\(pageNumber)"
        case .getProductDetails: servicePath = apiDomain + "products/getDetail"
        }
        return BaseURL + servicePath
    }
    
    var httpMethod: String {
        switch self {
        case .getProductList, .getProductDetails:
            return "GET"
        }
    }
    
    var parameters: stringAnyDict? {
        switch self {
        case .getProductDetails(let param):
            return param
        default:
            return nil
        }
    }
    
    var header: stringStringDict {
        var headerDict: stringStringDict = ["":""]
        headerDict[contentKey] = contentValue
        
        return headerDict
    }
}
