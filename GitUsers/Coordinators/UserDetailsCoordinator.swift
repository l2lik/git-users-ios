//
//  UserDetailsCoordinator.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

class UserDetailsCoordinator: Coordinator {
	private let router: Routable
	private let username: String
	
	init(router: Routable, username: String) {
		self.router = router
		self.username = username
	}
	
	override func start() {
		let scene = UserDetailsScene.build(username: username)
		router.push(scene)
	}
}
