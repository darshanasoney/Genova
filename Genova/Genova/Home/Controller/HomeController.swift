//
//  ViewController.swift
//  Genova
//
//  Created by home on 19/08/23.
//

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView  : UITableView!
    @IBOutlet weak var headerView  : UIView!
    
    var viewModel : HomeModelViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeModelViewModel(delegate: self)
        
        viewModel?.fetchData()
    }

    @IBAction func cartClicked(sender : UIButton) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
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
        
        let products = self.viewModel?.productList?.products
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeBanner.reuseIdentifier) as? HomeBanner else {
                return UITableViewCell()
            }
            cell.populate(type: .timeOffers)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeBanner.reuseIdentifier) as? HomeBanner else {
                return UITableViewCell()
            }
            cell.populate(type: .newOffers)
            return cell
            
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeBanner.reuseIdentifier) as? HomeBanner else {
                return UITableViewCell()
            }
            cell.populate(type: .specialOffer)
            return cell
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollection.reuseIdentifier) as? HomeCollection else {
                return UITableViewCell()
            }
            cell.populate(type: .mayLikeList,viewModel: self.viewModel)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollection.reuseIdentifier) as? HomeCollection else {
                return UITableViewCell()
            }
            cell.populate(type: .newOffersList,viewModel: self.viewModel)
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollection.reuseIdentifier) as? HomeCollection else {
                return UITableViewCell()
            }
            cell.populate(type: .seasonalOffersList,viewModel: self.viewModel)
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollection.reuseIdentifier) as? HomeCollection else {
                return UITableViewCell()
            }
            cell.populate(type: .itemsOnSaleList,viewModel: self.viewModel)
            return cell
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollection.reuseIdentifier) as? HomeCollection else {
                return UITableViewCell()
            }
            cell.populate(type: .bastSalerList,viewModel: self.viewModel)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "What you may like"
        case 4:
            return "SEASONAL OFFERS"
        case 5:
            return "ITEMS ON SALE"
        case 7:
            return "BEST SALLERS"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return Constants.screenHeight * 0.4
        case 1:
            return Constants.screenHeight * 0.2
        case 2:
            return Constants.screenHeight * 0.27
        case 3:
            return ((Constants.screenWidth / Constants.numberOfColumns) * Constants.numberOfRows) + Constants.padding
        case 4:
            let width = Constants.screenWidth * 0.7
            return width + Constants.cellPadding
            
        case 5:
            let width = Constants.screenWidth * 0.6
            return width + Constants.padding

        case 6:
            return Constants.screenHeight * 0.3
        case 7:
            let width = ((Constants.screenWidth / Constants.numberOfColumns) * Constants.numberOfRows) + Constants.padding
            return width + Constants.cellPadding
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return Constants.cellPadding
    }
    
    
}

extension HomeController : viewModelDelegate {
    func reloadData() {
        
        tableView.register(UINib(nibName:HomeBanner.reuseIdentifier, bundle: nil), forCellReuseIdentifier: HomeBanner.reuseIdentifier)
        tableView.register(UINib(nibName:HomeCollection.reuseIdentifier, bundle: nil), forCellReuseIdentifier: HomeCollection.reuseIdentifier)
        
        
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
