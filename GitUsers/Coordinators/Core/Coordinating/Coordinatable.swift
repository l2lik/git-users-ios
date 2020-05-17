//
//  Coordinatable.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

protocol Coordinatable: class {
	
	/// Calls when the flow has finished.
	var finishFlow: (() -> Void)? { get set }
	
	/// Starts coordinator's flow.
	/// - note: Must be overriden by a subclass.
	func start()
}
