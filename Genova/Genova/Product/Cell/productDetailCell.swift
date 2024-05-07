//
//  productDetailCell.swift
//  Genova
//
//  Created by home on 20/08/23.
//

import UIKit

class productDetailCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnAddToCart: UIButton!
    
    static var reuseIdentifier: String = String(describing: productDetailCell.self)
    
    var product : Product?
    
    override var frame: CGRect {
            get {
                return super.frame
            }
            set (newFrame) {
                var frame = newFrame
                frame.size.width = UIScreen.main.bounds.width
                super.frame = frame
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(product : Product?) {
        if let product = product {
            self.product = product
            self.lblPrice.text = "\(product.category)\n\(product.brand)\n\(product.price) AED"
            self.lblDiscount.text = "\(product.discountPercentage) %OFF"
            self.imgProduct.image = UIImage(named: product.thumbnail)
            self.lblSize.text = "\(product.stock)"
            self.lblDescription.text = product.description
        }
    }
    
    @IBAction func addToCart(_sender : UIButton) {
        CartManager.shared.addToCart(product: product)
    }
    
    @IBAction func plusClicked(_sender : UIButton) {
        self.product?.stockToCart = (self.product?.stockToCart ?? 0) + 1
        if let product = self.product {
            self.lblQty.text = "\(product.stockToCart)"
        }
    }
    
    @IBAction func minusClicked(_sender : UIButton) {
        
        if let product = self.product, product.stockToCart > 0 {
            self.product?.stockToCart = (self.product?.stockToCart ?? 0) - 1
            self.lblQty.text = "\(self.product?.stockToCart ?? 0)"
            if (self.product?.stockToCart ?? 0) == 0 {
                CartManager.shared.productsToCart  = CartManager.shared.productsToCart.filter({ obj in
                    return !(self.product?.id == obj.id)
                })
            }
        }
    }
    
    @IBAction func likeClicked(_sender : UIButton) {
        
    }
}
