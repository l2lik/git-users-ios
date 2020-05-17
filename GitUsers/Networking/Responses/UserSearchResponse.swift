//
//  UserSearchResponse.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 17.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

struct UserSearchResponse: Codable {
	let items: [UserResponse]
}
