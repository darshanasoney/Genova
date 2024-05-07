//
//  HomeViewModel.swift
//  Genova
//
//  Created by home on 21/08/23.
//

import Foundation



class ProductLogs {
    var products = [Product]()
    var error : String?
    
    init(products: [Product]?, error: String?) {
        self.products = products ?? []
        self.error = error
    }
}

class HomeModelViewModel {
    
    var delegate: viewModelDelegate
    var categories = [Categories]()
    var productList : ProductLogs?
    
    init(delegate: viewModelDelegate) {
        
        self.delegate = delegate
    }
    
    func fetchData() {
        
        Services.shared.fetchProducts(completionHandler: { response, error in
            if response != nil {
                    
                if let objAry = response as? [NSDictionary] {
                    let products = objAry.map { obj in
                        return Product(dict: obj)
                    }
                    self.productList = ProductLogs(products: products, error: error?.localizedDescription)
                    
                    
                    let categories = self.productList?.products.map { product in
                        return Categories(img: product.thumbnail, name: product.category)
                    }
                    
                    self.categories = categories ?? []
                    
                } else {
                        self.productList = ProductLogs(products: nil, error: error?.localizedDescription)
                }
            } else if error?.localizedDescription != "" {
                self.productList = ProductLogs(products: nil, error: error?.localizedDescription)
            }
        })
        self.prepareData()
    }
    
    func prepareData() {
        if self.productList?.products != nil {
            self.delegate.reloadData()
        } else if self.productList?.error != nil {
            self.delegate.showError(error: self.productList?.error)
        }
    }
}


@objc protocol viewModelDelegate {
    
    func reloadData()
    func showError(error: String?)
    @objc optional func showEmpty()
}
