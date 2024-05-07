//
//  CartViewController.swift
//  Genova
//
//  Created by home on 21/08/23.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView  : UITableView!
    @IBOutlet weak var emptyView  : UIView!
    @IBOutlet weak var lblTotalPrice  : UILabel!
    
    var viewModel : cartViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = cartViewModel(delegate: self)
        
        self.viewModel?.setData()
        
    }
    
    @IBAction func backClicked(_sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkOutClicked(_sender : UIButton){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsController") as? UserDetailsController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cartProducts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cartProductCell.reuseIdentifier) as? cartProductCell else {
            return UITableViewCell()
        }
        cell.populate(product: viewModel?.cartProducts[indexPath.row])
        cell.callBackRefresh = {
            self.viewModel?.setData()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension CartViewController : viewModelDelegate {
    
    func reloadData() {
        tableView.register(UINib(nibName:cartProductCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: cartProductCell.reuseIdentifier)
        emptyView.isHidden = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        var amount = 0
        
        self.viewModel?.cartProducts.forEach({ obj in
            amount = amount + (obj.price * obj.stockToCart)
        })
        
        self.lblTotalPrice.text = "\(amount) AED"
    }
    
    func showError(error: String?) {
        
    }
    
    func showEmpty() {
        emptyView.isHidden = false
        self.tableView.isHidden = true
    }
}
