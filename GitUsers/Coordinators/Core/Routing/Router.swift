//
//  Router.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

final class Router: NSObject {
	
	// MARK: - Properties
	
	var completions: [ UIViewController : () -> Void ]
	let navigationController: UINavigationController
	
	// MARK: - Init
	
	init(navigationController: UINavigationController = UINavigationController()) {
		self.completions = [:]
		self.navigationController = navigationController
		super.init()
		self.navigationController.delegate = self
	}
	
	// MARK: - Private Methods
	
	private func runCompletion(for controller: UIViewController) {
		guard let completion = completions[controller] else { return }
		completion()
		completions.removeValue(forKey: controller)
	}
}

// MARK: - Routable

extension Router: Routable {
	
	var rootViewController: UIViewController? {
		return navigationController.viewControllers.first
	}
	
	var hasRootController: Bool {
		return rootViewController != nil
	}
	
	func present(_ scene: Presentable) {
		present(scene, animated: true)
	}
	
	func present(_ scene: Presentable, animated: Bool) {
		scene.toPresent.modalPresentationStyle = .fullScreen
		navigationController.present(scene.toPresent, animated: animated, completion: nil)
	}
	
	func dismissScene() {
		dismissScene(animated: true, completion: nil)
	}
	
	func dismissScene(animated: Bool, completion: (() -> Void)?) {
		navigationController.dismiss(animated: animated, completion: completion)
	}
	
	func push(_ scene: Presentable)  {
		push(scene, animated: true)
	}
	
	func push(_ scene: Presentable, animated: Bool)  {
		push(scene, animated: animated, completion: nil)
	}
	
	func push(_ scene: Presentable, animated: Bool, completion: (() -> Void)?) {
		let controller = scene.toPresent
		
		guard !(controller is UINavigationController) else {
			assertionFailure("⚠️Deprecated push UINavigationController.")
			return
		}
		
		if let completion = completion {
			completions[controller] = completion
		}
		
		navigationController.pushViewController(scene.toPresent, animated: animated)
	}
	
	func popScene()  {
		popScene(animated: true)
	}
	
	func popScene(animated: Bool)  {
		if let controller = navigationController.popViewController(animated: animated) {
			runCompletion(for: controller)
		}
	}
	
	func popToRootScene(animated: Bool) {
		if let controllers = navigationController.popToRootViewController(animated: animated) {
			controllers.forEach { runCompletion(for: $0) }
		}
	}
	
	func setRootScene(_ scene: Presentable) {
		setRootScene(scene, hideBar: false)
	}
	
	func setRootScene(_ scene: Presentable, hideBar: Bool) {
		// Вызываем все замыкания, чтобы все координаторы уничтожились
		completions.forEach { $0.value() }
		
		navigationController.setViewControllers([scene.toPresent], animated: false)
		navigationController.isNavigationBarHidden = hideBar
	}
}

// MARK: - UINavigationControllerDelegate

extension Router: UINavigationControllerDelegate {
	func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
		
		// Ensure the view controller is popping
		guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
			!navigationController.viewControllers.contains(poppedViewController) else {
				return
		}
		
		runCompletion(for: poppedViewController)
	}
}
