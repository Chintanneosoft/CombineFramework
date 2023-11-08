//
//  ProductListing.swift
//  CombineFramework
//
//  Created by Neosoft on 07/11/23.
//

import Foundation

// MARK: REQUEST

struct RequestProductList : Codable {
    let product_category_id : Int?
    let limit : Int?
    let page : Int?
    
    enum CodingKeys: String, CodingKey {
        case product_category_id = "product_category_id"
        case limit = "limit"
        case page = "page"
    }
}

// MARK: RESPONSE

struct ProductListResponse : Codable {
    let status : Int?
    let data : [ProductListDetails]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

struct ProductListDetails : Codable, Hashable {
    let id : Int?
    let product_category_id : Int?
    let name : String?
    let producer : String?
    let description : String?
    let cost : Int?
    let rating : Int?
    let view_count : Int?
    let created : String?
    let modified : String?
    let product_images : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case product_category_id = "product_category_id"
        case name = "name"
        case producer = "producer"
        case description = "description"
        case cost = "cost"
        case rating = "rating"
        case view_count = "view_count"
        case created = "created"
        case modified = "modified"
        case product_images = "product_images"
    }
}

// MARK: ERROR

struct ProductListWrongMethod : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}

struct ProductListInvalidCategoryId : Codable {
    let status : Int?
    let data : Bool?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
        case user_msg = "user_msg"
    }
}

struct ProductListDataMissing : Codable {
    let status : Int?
    let message : String?
    let user_msg : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case user_msg = "user_msg"
    }
}
