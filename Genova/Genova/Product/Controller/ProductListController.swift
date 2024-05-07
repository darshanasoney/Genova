//
//  ProductListController.swift
//  Genova
//
//  Created by home on 20/08/23.
//

import UIKit

class ProductListController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    var viewModel : HomeModelViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HomeModelViewModel(delegate: self)
        self.viewModel?.fetchData()
    }
    
    @IBAction func backPressed(_sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.productList?.products.count ??  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCollectionList.reuseIdentifier, for: indexPath) as? productCollectionList else {
            return UICollectionViewCell()
        }
        if let product = self.viewModel?.productList?.products[indexPath.row] {
            cell.populate(product: product)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let width = UIScreen.main.bounds.size.width / 2
            return CGSize(width: width - 5, height: width + 50)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailController") as? ProductDetailController {
            vc.product = self.viewModel?.productList?.products[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProductListController : viewModelDelegate {
    func reloadData() {
        
        collectionView.register(UINib(nibName:productCollectionList.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: productCollectionList.reuseIdentifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    func showError(error: String?) {
        let alert = UIAlertController(title: "Genova", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    
}
