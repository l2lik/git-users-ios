//
//  GithubNetworkEnvironment.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 16.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

struct GithubNetworkEnvironment: NetworkEnvironment {
	var host: String { return "https://api.github.com" }
	
	var headers: [String: String] {
		return [
			"Accept": "application/vnd.github.v3+json",
			"Authorization": "token 8fd9c1448a6fd741176edbb511add1067687ad0d"
		]
	}
}
