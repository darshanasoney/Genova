//
//  CartManager.swift
//  Genova
//
//  Created by home on 21/08/23.
//

import Foundation
import UIKit

class CartManager {
    
    static let shared = CartManager()
    
    private init() {
        
    }
    
    var productsToCart = [Product]()
    
    func addToCart(product : Product?) {
        if let product = product {
            if CartManager.shared.productsToCart.contains(where: { obj in
                return product.id == obj.id
            }){
                CartManager.shared.productsToCart.forEach { pr in
                    if pr.id == product.id { pr.stockToCart = pr.stockToCart + 1 }
                }
            } else {
                if product.stockToCart == 0 { product.stockToCart = 1 }
                CartManager.shared.productsToCart.append(product)
            }
        }
        
        
        let alert = UIAlertController(title: "Genova", message: "Added to cart", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            alert.dismiss(animated: true)
        }))
        
        APPDELEGATE.window?.rootViewController?.present(alert, animated: true)
    }
    
    func removeFromCart(product : Product?) {
        if let product = product {
            CartManager.shared.productsToCart  = CartManager.shared.productsToCart.filter({ obj in
                return !(product.id == obj.id)
            })
        }
    }
    
    func plusClicked(product : Product?) {
        if let product = product {
            product.stockToCart = (product.stockToCart) + 1
        }
    }
    
    func minusClicked(product : Product?) {
        if let product = product, product.stockToCart > 0 {
            product.stockToCart = (product.stockToCart) - 1
            if (product.stockToCart) == 0 {
                CartManager.shared.productsToCart  = CartManager.shared.productsToCart.filter({ obj in
                    return !(product.id == obj.id)
                })
            }
        }
    }
}
