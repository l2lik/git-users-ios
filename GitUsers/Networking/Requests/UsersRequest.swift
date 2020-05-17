//
//  UsersRequest.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 17.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

enum UsersRequest: NetworkRequest {
	case all(since: Int?)
	case single(username: String)
	case search(query: String)
	
	var path: String {
		switch self {
		case .all: return "/users"
		case .single(let username): return "/users/\(username)"
		case .search: return "/search/users"
		}
	}
	
	var parameters: [String : Any]? {
		switch self {
		case .all(let since):
			if let since = since {
				return ["since": since]
			} else { return nil }
		case .search(let query):
			return ["q": query]
		default: return nil
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .all: return .get
		case .single: return .get
		case .search: return .get
		}
	}
}

struct AllUsersTask: NetworkOperation {
	typealias Output = [UserResponse]
	
	let since: Int?
	
	var request: NetworkRequest {
		return UsersRequest.all(since: since)
	}
}

struct SingleUserTask: NetworkOperation {
	typealias Output = UserResponse
	
	let username: String
	
	var request: NetworkRequest {
		return UsersRequest.single(username: username)
	}
}

struct SearchUserTask: NetworkOperation {
	typealias Output = UserSearchResponse
	
	let query: String
	
	var request: NetworkRequest {
		return UsersRequest.search(query: query)
	}
}
