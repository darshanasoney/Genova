//
//  cartProductCell.swift
//  Genova
//
//  Created by home on 20/08/23.
//

import UIKit

class cartProductCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    static var reuseIdentifier: String = String(describing: cartProductCell.self)
    
    var callBackRefresh : (() -> Void)?
    
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
        if let product  = product {
            self.product = product
            self.lblName.text = product.brand
            self.lblPrice.text = "\(product.price) AED"
            lblSize.text = "\(product.stock)"
            lblCategory.text = product.category
            lblQty.text = "\(product.stockToCart)"
            imgProduct.image = UIImage(named: product.thumbnail)
        }
    }
    
    @IBAction func remove(_sender : UIButton) {
        CartManager.shared.removeFromCart(product: self.product)
        callBackRefresh?()
    }
    
    @IBAction func plusClicked(_sender : UIButton) {
        CartManager.shared.productsToCart.forEach { obj in
            if self.product?.id == obj.id { obj.stockToCart = obj.stockToCart + 1}
        }
        callBackRefresh?()
    }
    
    @IBAction func minusClicked(_sender : UIButton) {
        CartManager.shared.minusClicked(product: product)
        callBackRefresh?()
    }
}
