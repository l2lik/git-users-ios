//
//  Users.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

enum Users {
	struct ViewModel {
		struct CellViewModel {
			let avatarURL: URL?
			let username: String?
		}
		
		let users: [CellViewModel]
	}
}
