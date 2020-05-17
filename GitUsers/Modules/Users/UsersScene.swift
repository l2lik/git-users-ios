//
//  UsersScene.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

class UsersScene {
	static func build(didSelectUser: ((String) -> Void)?) -> UsersView {
		let view = UsersView()
		let interactor = UsersInteractor()
		let presenter = UsersPresenter()
		view.interactor = interactor
		view.didSelectUser = didSelectUser
		interactor.presenter = presenter
		presenter.view = view
		return view
	}
}
