//
//  productCollectionList.swift
//  Genova
//
//  Created by home on 20/08/23.
//

import UIKit

class productCollectionList: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var imgProduct: UIImageView!
    
    static var reuseIdentifier: String = String(describing: productCollectionList.self)
    
    static var reuseSimpleIdentifier: String = String(describing: "productCollectionSimpleList")
    
    var product : Product?
    
    func populate(product : Product?) {
        if let product = product {
            self.product = product
            self.bgView.layer.cornerRadius = 5
            self.bgView.layer.masksToBounds = false
            self.bgView.layer.shadowColor = UIColor.gray.cgColor
            self.bgView.layer.shadowOpacity = 0.2
            self.bgView.layer.shadowOffset = CGSize(width: -1, height: 1)
            self.bgView.layer.shadowRadius = 5
            self.lblPrice.text = "\(product.category)\n\(product.brand)\n\(product.price) AED"
            self.lblDiscount.text = "\(product.discountPercentage) % off"
            self.imgProduct.image = UIImage(named: product.thumbnail)
            self.btnCart.tag = product.id
        }
    }
    
    func populateSimpleView(categoroy : Categories?) {
        if let categoroy = categoroy {
            self.bgView.layer.cornerRadius = 5
            self.bgView.layer.masksToBounds = false
            self.bgView.layer.shadowColor = UIColor.gray.cgColor
            self.bgView.layer.shadowOpacity = 0.2
            self.bgView.layer.shadowOffset = CGSize(width: -1, height: 1)
            self.bgView.layer.shadowRadius = 5
            self.lblPrice.text = categoroy.name
            self.imgProduct.image = UIImage(named: categoroy.img)
        }
    }
    
    @IBAction func likeClicked(_sender : UIButton) {
        self.imgHeart.isHighlighted = !self.imgHeart.isHighlighted
    }

    @IBAction func addToCartClicked(_sender : UIButton) {
        if let product = self.product {
            CartManager.shared.addToCart(product: product)
        }
    }
}


