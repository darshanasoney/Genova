//
//  reviewCell.swift
//  Genova
//
//  Created by home on 20/08/23.
//

import UIKit
import Cosmos

class reviewCell: UITableViewCell {
    
    @IBOutlet weak var addView : UIView!
    @IBOutlet weak var reviewView : CosmosView!
    @IBOutlet weak var allReviewView : UIView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblReview : UILabel!
    
    static var reuseIdentifier: String = String(describing: reviewCell.self)
    
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
            self.lblName.text = product.userName
            self.lblDate.text = product.date
            self.lblReview.text = product.review
            self.reviewView.rating = product.rating
            
            self.addView.layer.cornerRadius = 5
            self.addView.layer.masksToBounds = false
            self.addView.layer.shadowColor = UIColor.gray.cgColor
            self.addView.layer.shadowOpacity = 0.5
            self.addView.layer.shadowOffset = CGSize(width: -2, height: 2)
            self.addView.layer.shadowRadius = 5
            
            self.allReviewView.layer.cornerRadius = 5
            self.allReviewView.layer.masksToBounds = false
            self.allReviewView.layer.shadowColor = UIColor.gray.cgColor
            self.allReviewView.layer.shadowOpacity = 0.5
            self.allReviewView.layer.shadowOffset = CGSize(width: -2, height: 2)
            self.allReviewView.layer.shadowRadius = 5
        }
    }
    
    @IBAction func addClicked(_sender : UIButton) {
        
    }
    
    @IBAction func allReviewClicked(_sender : UIButton) {
        
    }
    
}
