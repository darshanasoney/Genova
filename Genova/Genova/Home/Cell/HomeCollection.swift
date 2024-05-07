//
//  HomeCollection.swift
//  Genova
//
//  Created by home on 19/08/23.
//

import UIKit

enum HomeListTtype {
    case mayLikeList
    case newOffersList
    case seasonalOffersList
    case itemsOnSaleList
    case bastSalerList
}

class HomeCollection: UITableViewCell, viewModelDelegate {
    func reloadData() {
        
    }
    
    func showError(error: String?) {
        
    }
    

    static var reuseIdentifier: String = String(describing: HomeCollection.self)
    @IBOutlet weak var collection : UICollectionView!
    
    var currentType : HomeListTtype?
    var  viewModel : HomeModelViewModel?
    
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
    
    func populate(type : HomeListTtype, viewModel : HomeModelViewModel?) {
        
        self.viewModel = viewModel
        self.currentType  = type
        
        collection.register(UINib(nibName:productCollectionList.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: productCollectionList.reuseIdentifier)

        collection.register(UINib(nibName:productCollectionList.reuseSimpleIdentifier, bundle: nil), forCellWithReuseIdentifier: productCollectionList.reuseSimpleIdentifier)
        
        switch self.currentType {
            
            case .mayLikeList:
            if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                collection.isScrollEnabled = true
            }
                break
            case .newOffersList:
            if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
                collection.isScrollEnabled = false
            }
                break
            case .seasonalOffersList:
            if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                collection.isScrollEnabled = true
            }
                break
            case .itemsOnSaleList:
            if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                collection.isScrollEnabled = true
            }
                break
            case .bastSalerList:
            if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
                collection.isScrollEnabled = false
            }
                break
        case .none:
            break
        }
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()

        
        
    }
}

extension HomeCollection : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.currentType == .mayLikeList {
            return self.viewModel?.categories.count ?? 0
        } else {
            return self.viewModel?.productList?.products.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.currentType {
        case .mayLikeList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCollectionList.reuseSimpleIdentifier, for: indexPath) as? productCollectionList else {
                return UICollectionViewCell()
            }
            
            cell.populateSimpleView(categoroy: self.viewModel?.categories[indexPath.row])
            return cell
        case .none:
            return UICollectionViewCell()
        case .some(.newOffersList):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCollectionList.reuseIdentifier, for: indexPath) as? productCollectionList else {
                return UICollectionViewCell()
            }
            
            cell.populate(product: self.viewModel?.productList?.products[indexPath.row])
            return cell
        case .seasonalOffersList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCollectionList.reuseIdentifier, for: indexPath) as? productCollectionList else {
                return UICollectionViewCell()
            }
            
            cell.populate(product: self.viewModel?.productList?.products[indexPath.row])
            return cell
        case .itemsOnSaleList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCollectionList.reuseIdentifier, for: indexPath) as? productCollectionList else {
                return UICollectionViewCell()
            }
            
            cell.populate(product: self.viewModel?.productList?.products[indexPath.row])
            return cell
        case .bastSalerList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCollectionList.reuseIdentifier, for: indexPath) as? productCollectionList else {
                return UICollectionViewCell()
            }
            
            cell.populate(product: self.viewModel?.productList?.products[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch self.currentType {
            
        case .mayLikeList:
            
            return CGSize(width: UIScreen.main.bounds.size.width / 3, height: UIScreen.main.bounds.size.width / 3)
            
        case .newOffersList:
            let width = UIScreen.main.bounds.size.width / 2
            return CGSize(width: width - 5, height: width + 10)
            
        case .seasonalOffersList:
            let width = UIScreen.main.bounds.size.width * 0.7
            return CGSize(width: width, height: width + 10)
        
        case .itemsOnSaleList:
            let width = UIScreen.main.bounds.size.width * 0.6
            return CGSize(width: width, height: width + 20)
        
        case .bastSalerList:
            let width = UIScreen.main.bounds.size.width / 2
            return CGSize(width: width - 5, height: width + 20)
        case .none:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListController") as? ProductListController {
            if let root = APPDELEGATE.window?.rootViewController as? UINavigationController {
                root.pushViewController(vc, animated: true)
            }
        }
        
        
    }
}
