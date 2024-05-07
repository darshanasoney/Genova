//
//  noReviewCell.swift
//  Genova
//
//  Created by home on 20/08/23.
//

import UIKit

class noReviewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
     
    static var reuseIdentifier: String = String(describing: noReviewCell.self)
    
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
    
    func populate() {

        self.bgView.layer.cornerRadius = 5
        self.bgView.layer.masksToBounds = false
        self.bgView.layer.shadowColor = UIColor.gray.cgColor
        self.bgView.layer.shadowOpacity = 0.5
        self.bgView.layer.shadowOffset = CGSize(width: -2, height: 2)
        self.bgView.layer.shadowRadius = 5
    }
    
    @IBAction func addReviewCart(_sender : UIButton) {
        
    }
}
