//
//  HomeViewModel.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 26/10/23.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func updateData()
    func showErrorView()
}

extension HomeViewDelegate {
    func updateData() {}
    func showErrorView() {}
}

class HomeViewModel {
    
    weak var delegate: HomeViewDelegate?
    var model: UserData?
    
    private let apiUrl = URL(string: AppConstants.URL.homeApiUrl.value)!
    
    init(delegate: HomeViewDelegate? = nil, model: UserData? = nil) {
        self.delegate = delegate
        self.model = model
    }
    
    func fetchData() {
        guard let apiUrl = URL(string: AppConstants.URL.homeApiUrl.value) else {
            self.fetchFromCachedData()
            return
        }
        
        NetworkService.shared.requestData(from: apiUrl, cacheKey: AppConstants.UserDefaultsPath.homeApiData.value, responseType: UserData.self) { [weak self] result in
            switch result {
            case .success(let userData):
                self?.model = userData
                DispatchQueue.main.async {
                    self?.delegate?.updateData()
                }
            case .failure(let error):
                print("Network Error: \(error)")
                self?.fetchFromCachedData()
            }
        }
    }
    private func fetchFromCachedData() {
        if let data = CacheManager.shared.loadData(forKey: AppConstants.UserDefaultsPath.homeApiData.value) {
            do {
                let model = try JSONDecoder().decode(UserData.self, from: data)
                self.model = model
                self.delegate?.updateData()
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.showErrorView()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.delegate?.showErrorView()
            }
        }
    }
}
