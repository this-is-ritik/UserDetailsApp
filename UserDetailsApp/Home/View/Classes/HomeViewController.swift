//
//  HomeViewController.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 26/10/23.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var errorView: UIStackView!
    @IBOutlet weak private var errorImgView: UIImageView!
    
    private var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        self.navigationItem.backButtonDisplayMode = .minimal
        self.tableView.register(UINib(nibName: UserDetailTVC.reuseIdentifier, bundle: .main), forCellReuseIdentifier: UserDetailTVC.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel = HomeViewModel(delegate: self)
        self.viewModel.fetchData()
    }
    
    @IBAction private func retryBtnTapped(_ sender: Any) {
        self.viewModel.fetchData()
    }
}



extension HomeViewController: HomeViewDelegate {
    func updateData() {
        self.tableView.isHidden = false
        self.errorView.isHidden = true
        self.tableView.reloadData()
    }
    func showErrorView() {
        self.tableView.isHidden = true
        self.errorView.isHidden = false
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.model?.data?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = self.viewModel.model?.data?[indexPath.section] else {return UITableViewCell()}
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTVC.reuseIdentifier, for: indexPath) as? UserDetailTVC {
            cell.configure(with: data)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = self.viewModel.model?.data?[indexPath.section] else {return}
        self.openDetails(with: data)
    }
}


extension HomeViewController {
    private func openDetails(with model: UserData.User) {
        let vc = UIHostingController(rootView: UserDetailsView(model: model))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
