//
//  Product-Category.swift
//  Genova
//
//  Created by home on 21/08/23.
//

import Foundation
class Categories {
    
    var img = ""
    var name = ""
    
    init(img: String = "", name: String = "") {
        self.img = img
        self.name = name
    }
}

class Product {
    
    var id = 0
    var title = ""
    var description = ""
    var price = 0
    var discountPercentage : Double = 0
    var rating : Double = 0
    var stock = 0
    var brand = ""
    var category = ""
    var thumbnail = ""
    var review = ""
    var userName = ""
    var date = ""
    var stockToCart = 0
    
    init(dict: NSDictionary) {
        id = dict.object(forKey: "id") as? Int ?? 0
        title = dict.object(forKey: "title") as? String ?? ""
        description = dict.object(forKey: "description") as? String ?? ""
        price = dict.object(forKey: "price") as? Int ?? 0
        discountPercentage = dict.object(forKey: "discountPercentage") as? Double ?? 0
        rating = dict.object(forKey: "rating") as? Double ?? 0
        stock = dict.object(forKey: "stock") as? Int ?? 0
        brand = dict.object(forKey: "brand") as? String ?? ""
        category = dict.object(forKey: "category") as? String ?? ""
        thumbnail = dict.object(forKey: "thumbnail") as? String ?? ""
        review = dict.object(forKey: "review") as? String ?? ""
        userName = dict.object(forKey: "userName") as? String ?? ""
        date = dict.object(forKey: "date") as? String ?? ""
    }
}

