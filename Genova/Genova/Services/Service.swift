//
//  Service.swift
//  Genova
//
//  Created by home on 21/08/23.
//

import Foundation

class Services {

    static let shared = Services()
    
    private init() {
        
    }
    
    func fetchProducts(completionHandler : @escaping ([Any]?, Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "product", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["products"] as? [Any] {
                      completionHandler(person, nil)
                  }
              } catch {
                  completionHandler(nil, error)
              }
        }
    }
}

