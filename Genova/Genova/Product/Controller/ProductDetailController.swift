//
//  ProductDetailController.swift
//  Genova
//
//  Created by home on 20/08/23.
//

import UIKit

class ProductDetailController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView  : UITableView!
    
    var hasReview = true
    var viewModel : HomeModelViewModel?
    
    var product : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HomeModelViewModel(delegate: self)
        
        self.viewModel?.fetchData()
    }

    @IBAction func backClicked(_sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView

        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        let headerFrame = header.frame
        header.textLabel?.frame = headerFrame;
        header.textLabel?.textAlignment = .left
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: productDetailCell.reuseIdentifier) as? productDetailCell else {
                return UITableViewCell()
            }
            cell.populate(product: product)
            return cell
        case 1:
            
            if self.product?.rating != 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: reviewCell.reuseIdentifier) as? reviewCell else {
                    return UITableViewCell()
                }
                cell.populate(product: product)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: noReviewCell.reuseIdentifier) as? noReviewCell else {
                    return UITableViewCell()
                }
                cell.populate()
                return cell
            }
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollection.reuseIdentifier) as? HomeCollection else {
                return UITableViewCell()
            }
            cell.populate(type: .seasonalOffersList, viewModel: viewModel)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "REVIEWS"
        case 2:
            return "SIMILAR PRODUCTS"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return UITableView.automaticDimension
        case 2:
            let width = Constants.screenWidth * 0.7
            return width + Constants.cellPadding
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return Constants.cellPadding
    }
    
}

extension ProductDetailController : viewModelDelegate {
    func reloadData() {
        tableView.register(UINib(nibName:productDetailCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: productDetailCell.reuseIdentifier)
        tableView.register(UINib(nibName:HomeCollection.reuseIdentifier, bundle: nil), forCellReuseIdentifier: HomeCollection.reuseIdentifier)
        tableView.register(UINib(nibName:noReviewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: noReviewCell.reuseIdentifier)
        tableView.register(UINib(nibName:reviewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: reviewCell.reuseIdentifier)
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    func showError(error: String?) {
        let alert = UIAlertController(title: "Genova", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    
}
