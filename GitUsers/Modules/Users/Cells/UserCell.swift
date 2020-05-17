//
//  UserCell.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
	@IBOutlet weak var avatarImageView: UIImageView! {
		didSet {
			avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
			avatarImageView.layer.masksToBounds = true
		}
	}
	@IBOutlet weak var usernameLabel: UILabel!
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		avatarImageView.image = nil
		usernameLabel.text = nil
	}
    
	func configure(with viewModel: Users.ViewModel.CellViewModel) {
		if let avatarURL = viewModel.avatarURL {
			avatarImageView.setImage(with: avatarURL)
		}
		usernameLabel.text = viewModel.username
	}
}
