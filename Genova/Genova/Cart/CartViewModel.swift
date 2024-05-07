//
//  CartViewModel.swift
//  Genova
//
//  Created by home on 21/08/23.
//

import Foundation

class cartViewModel {
    
    var cartProducts = [Product]()
    var delegate : viewModelDelegate
    
    init(delegate: viewModelDelegate) {
        
        self.delegate = delegate
    }
    
    func setData() {
        self.cartProducts = CartManager.shared.productsToCart
        
        if self.cartProducts.count > 0 {
            self.delegate.reloadData()
        } else {
            self.delegate.showEmpty?()
        }
    }
}
