//
//  HomeBanner.swift
//  Genova
//
//  Created by home on 19/08/23.
//

import UIKit

enum HomeType {
    
    case timeOffers
    case newOffers
    case specialOffer
    
}

class HomeBanner: UITableViewCell {

    static var reuseIdentifier: String = String(describing: HomeBanner.self)
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var bgView : UIView!
    
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
    
    func populate(type : HomeType) {
        switch type {
        case .timeOffers:
            self.lblTitle.attributedText = self.setLimitedText(first: Constants.timeOfferText, second: Constants.timeOfferValue)
            self.img.image = UIImage(named: "perfume_banner")
            self.bgView.layer.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
            break
        
        case .newOffers:
            self.lblTitle.attributedText = self.setLimitedText(first: Constants.newOfferText, second: Constants.newOfferValue)
            
            self.img.image = UIImage(named: "Rectangle 14")
            self.bgView.layer.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
            break
            
        case .specialOffer:
            self.lblTitle.attributedText = self.setLimitedText(first: Constants.specialOfferText, second: Constants.specialOfferValue,"AED 50.00")
            self.img.image = UIImage(named: "24")
            self.bgView.layer.backgroundColor = UIColor(red: 237/255, green: 114/255, blue: 120/255, alpha: 1).cgColor
            break
            
        }
    }

    func setLimitedText(first: String, second: String, _ third: String = "") -> NSAttributedString {
        
        let title = NSAttributedString(string: first,attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
        
        let bottom = NSAttributedString(string: second,attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        
        let third = NSAttributedString(string: third,attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
        
        let final = NSMutableAttributedString(attributedString: title)
        
        final.append(bottom)
        final.append(third)
        
        return final
        
    }
    
}


class Constants {
    
    static let timeOfferValue = "Shop Bath & Ritual at AED/SAR \n500, Retail price AED/SAR 800"
    static let timeOfferText = "Limited time Offer\n"
    
    static let newOfferValue = "Lorem ipsum dolor sit amet,\n consectetur adipiscing elit, \nsed do eiusmod tempor"
    static let newOfferText = "New Offers\n"
    
    static let specialOfferValue = "Lorem ipsum dolor sit amet,\n consectetur adipiscing elit,\n sed do eiusmod tempor "
    static let specialOfferText = "Roberto Cavalli\n"
    
    static let screenHeight : CGFloat = UIScreen.main.bounds.height
    static let screenWidth : CGFloat = UIScreen.main.bounds.width
    static let padding : CGFloat = 30
    static let cellPadding : CGFloat = 20
    static let numberOfRows : CGFloat = 2
    static let numberOfColumns : CGFloat = 2
    
}
