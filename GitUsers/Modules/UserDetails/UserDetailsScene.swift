//
//  UserDetailsScene.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

class UserDetailsScene {
	static func build(username: String) -> UserDetailsView {
		let view = UserDetailsView()
		let interactor = UserDetailsInteractor(username: username)
		let presenter = UserDetailsPresenter()
		view.interactor = interactor
		interactor.presenter = presenter
		presenter.view = view
		return view
	}
}
