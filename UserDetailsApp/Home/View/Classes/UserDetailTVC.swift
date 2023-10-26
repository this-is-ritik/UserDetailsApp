//
//  UserDetailTVC.swift
//  UserDetailsApp
//
//  Created by Ritik Sharma on 26/10/23.
//

import UIKit
import SDWebImage

class UserDetailTVC: UITableViewCell {

    @IBOutlet weak private var fNameLbl: UILabel!
    @IBOutlet weak private var lastNameLbl: UILabel!
    @IBOutlet weak private var emailLbl: UILabel!
    @IBOutlet weak private var avatarImgView: UIImageView!
    @IBOutlet weak private var mainStackView: UIStackView!
    
    static let reuseIdentifier: String = "UserDetailTVC"
    var model: UserData.User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupFonts()
        self.setupColors()
        self.mainStackView.isLayoutMarginsRelativeArrangement = true
        self.mainStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    }
    
    private func setupFonts() {
        self.emailLbl.font = UIFont.systemFont(ofSize: 14)
        self.fNameLbl.font = UIFont.systemFont(ofSize: 20)
        self.lastNameLbl.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func setupColors() {
        self.emailLbl.textColor = UIColor.lightGray
        self.fNameLbl.textColor = UIColor.darkGray
        self.lastNameLbl.textColor = UIColor.darkGray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.avatarImgView.image = nil
        self.avatarImgView.isHidden = true
        self.fNameLbl.text = nil
        self.lastNameLbl.text = nil
        self.emailLbl.text = nil
        self.mainStackView.layer.borderWidth = 0
        self.mainStackView.layer.cornerRadius = 0
    }
    
    func configure(with model: UserData.User) {
        self.model = model
        self.avatarImgView.isHidden = true
        if let urlStr = self.model?.avatar {
            self.avatarImgView.sd_setImage(with: URL(string: urlStr)) { (image, error, cacheType, url) in
                if image != nil {
                    self.avatarImgView.isHidden = false
                    self.avatarImgView.layer.cornerRadius = self.avatarImgView.bounds.size.height/2
                    self.avatarImgView.layer.borderWidth = 1
                    self.avatarImgView.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
        }
        self.fNameLbl.text = self.model?.firstName
        self.lastNameLbl.text = self.model?.lastName
        self.emailLbl.text = self.model?.email
        self.mainStackView.layer.borderColor = UIColor.lightGray.cgColor
        self.mainStackView.layer.borderWidth = 1
        self.mainStackView.layer.cornerRadius = 16
        
    }
}
