//
//  UsersInteractor.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

protocol UsersBusinessLogic: class {
	func fetchUsers()
	func searchUsers(query: String)
}

class UsersInteractor {
	var presenter: UsersPresentationLogic?
	
	private let networkDispatcher = DefaultNetworkDispatcher(environment: GithubNetworkEnvironment())
	
	private var users: [UserResponse] = []
}

// MARK: - UsersBusinessLogic
extension UsersInteractor: UsersBusinessLogic {
	func fetchUsers() {
		var sinceId: Int?
		
		if let lastUser = users.last {
			sinceId = lastUser.id
		}
		
		AllUsersTask(since: sinceId).execute(in: networkDispatcher) { [weak self] (result) in
			guard let self = self else { return }
			
			switch result {
			case .success(let users):
				self.users.append(contentsOf: users)
				self.presenter?.presentUsers(users: self.users)
			case .failure(let error):
				self.presenter?.presentError(error: error)
			}
		}
	}
	
	func searchUsers(query: String) {
		SearchUserTask(query: query).execute(in: networkDispatcher) { [weak self] (result) in
			guard let self = self else { return }
			
			switch result {
			case .success(let searchResult):
				self.presenter?.presentFoundUsers(users: searchResult.items)
			case .failure(let error):
				self.presenter?.presentError(error: error)
			}
		}
	}
}

