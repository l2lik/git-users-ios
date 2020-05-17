//
//  AppDelegate.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
	private lazy var rootController: UINavigationController = .init()
	private lazy var router: Router = .init(navigationController: rootController)
	private lazy var coordinator: AppCoordinator = .init(router: router)
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Setup window
		window = makeWindow(rootController: rootController)
		window?.makeKeyAndVisible()
		
		// Стартуем флоу юзера
		coordinator.start()
		return true
	}
	
	private func makeWindow(rootController: UIViewController) -> UIWindow {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.backgroundColor = UIColor.white
		window.rootViewController = rootController
		
		return window
	}
}

