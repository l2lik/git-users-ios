//
//  AppCoordinator.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
	private let router: Routable
	
	init(router: Routable) {
		self.router = router
	}
	
	override func start() {
		showUsersFlow()
	}
	
	private func showUsersFlow() {
		let coordinator = UsersCoordinator(router: router)
		addChild(coordinator)
		coordinator.start()
	}
}
