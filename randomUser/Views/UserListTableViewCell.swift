//
//  UserListTableViewCell.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 19/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit
import Kingfisher

class UserListTableViewCell: UITableViewCell {
    
    let userProfile: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.layoutIfNeeded()
        
        return image
    }()
    
    let userName:UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userDetail:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = label.font.withSize(14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(){
        self.backgroundColor = .clear
        self.addSubview(userProfile)
        self.addSubview(userName)
        self.addSubview(userDetail)
        userProfile.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        userProfile.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        userProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        userProfile.widthAnchor.constraint(equalTo: userProfile.heightAnchor, multiplier: 1).isActive = true
        
        userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        userName.leadingAnchor.constraint(equalTo: userProfile.trailingAnchor, constant: 20).isActive = true
        userName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        userDetail.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10).isActive = true
        userDetail.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        userDetail.leadingAnchor.constraint(equalTo: userProfile.trailingAnchor, constant: 20).isActive = true
        userDetail.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillWithUser(user:User){
        userName.text = "\(user.name.title). \(user.name.first) \(user.name.last)"
        userDetail.text = "\(user.location.country) \(user.location.state) \(user.location.city)"
        userProfile.kf.setImage(
            with: URL(string: user.picture.large),
            placeholder: #imageLiteral(resourceName: "whoIs"),
            options: [.transition(.fade(1))]
        )
    }
    
    func fillWithError(){
        userProfile.image = #imageLiteral(resourceName: "whoIs")
        userName.text = "Unknow"
        userDetail.text = "Unknow"
        userProfile.layer.cornerRadius = userProfile.frame.height/2
        userProfile.layoutIfNeeded()
    }
}
