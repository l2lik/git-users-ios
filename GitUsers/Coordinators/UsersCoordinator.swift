//
//  UsersCoordinator.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

class UsersCoordinator: Coordinator {
	private let router: Routable
	
	init(router: Routable) {
		self.router = router
	}
	
	override func start() {
		let scene = UsersScene.build(didSelectUser: { [weak self] username in
			self?.performUserDetailsFlow(username: username)
		})
		router.setRootScene(scene)
	}
	
	private func performUserDetailsFlow(username: String) {
		let coordinator = UserDetailsCoordinator(router: router, username: username)
		coordinator.finishFlow = { [weak self, coordinator] in
			self?.removeChild(coordinator)
		}
		addChild(coordinator)
		coordinator.start()
	}
}
