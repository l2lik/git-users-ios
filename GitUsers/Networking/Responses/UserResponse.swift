//
//  UserDTO.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 17.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
	let id: Int
	let login: String
	let avatarUrl: URL?
}
