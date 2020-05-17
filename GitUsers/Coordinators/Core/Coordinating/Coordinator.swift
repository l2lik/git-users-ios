//
//  Coordinator.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

class Coordinator: NSObject, Coordinatable {
	/// List of child coordinators.
	private var children: [Coordinatable] = []
	
	/// Adds a child coordinator to the his parent.
	func addChild(_ coordinator: Coordinatable) {
		if children.contains(where: { $0 === coordinator }) { return }
		
		children.append(coordinator)
	}
	
	/// Removes a child coordinator from the his parent.
	func removeChild(_ coordinator: Coordinatable) {
		if children.isEmpty { return }
		
		// If index is empty there is nothing to remove
		guard let index = children.firstIndex(where: { $0 === coordinator }) else {
			return
		}
		
		children.remove(at: index)
	}
	
	// MARK: - Coordinatable
	
	var finishFlow: (() -> Void)?
	
	func start() {}
}
