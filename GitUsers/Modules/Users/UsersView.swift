//
//  UsersView.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

protocol UsersDisplayLogic: class {
	func displayUsers(viewModel: Users.ViewModel)
	func displayFoundUsers(viewModel: Users.ViewModel)
	func displayError(error: Error)
}

class UsersView: UIViewController {
	var didSelectUser: ((String) -> Void)?
	var interactor: UsersBusinessLogic?
	
	@IBOutlet weak var usersTableView: UITableView!
	
	private let searchController = UISearchController(searchResultsController: nil)
	
	private var displayedUsers: [Users.ViewModel.CellViewModel] = [] {
		didSet {
			usersTableView.reloadData()
		}
	}
	private var searchResultUsers: [Users.ViewModel.CellViewModel] = [] {
		didSet {
			usersTableView.reloadData()
		}
	}
	private var isLoading: Bool = false
	private var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "GitHub Users"
		
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Type login..."
		navigationItem.searchController = searchController
		definesPresentationContext = true

		usersTableView.registerCell(UserCell.self)
		usersTableView.delegate = self
		usersTableView.dataSource = self
		
		interactor?.fetchUsers()
    }
}

// MARK: - UsersDisplayLogic
extension UsersView: UsersDisplayLogic {
	func displayUsers(viewModel: Users.ViewModel) {
		displayedUsers = viewModel.users
		isLoading = false
	}
	
	func displayFoundUsers(viewModel: Users.ViewModel) {
		searchResultUsers = viewModel.users
	}
	
	func displayError(error: Error) {
		showError(error)
	}
}

// MARK: - UITableViewDataSource
extension UsersView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return isSearching ? searchResultUsers.count : displayedUsers.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(UserCell.self, forIndexPath: indexPath)
		cell.configure(with: isSearching ? searchResultUsers[indexPath.row] : displayedUsers[indexPath.row])
		return cell
	}
}

// MARK: - UITableViewDelegate
extension UsersView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if isSearching { return }
		
		if indexPath.row == displayedUsers.count - 1, !isLoading {
			isLoading = true
			interactor?.fetchUsers()
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let username = isSearching ? searchResultUsers[indexPath.row].username : displayedUsers[indexPath.row].username else { return }
		
		didSelectUser?(username)
	}
}

// MARK: - UISearchResultsUpdating
extension UsersView: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		let query = searchBar.text ?? ""
		
		isSearching = !query.isEmpty
		
		if isSearching {
			interactor?.searchUsers(query: query)
		}
		
		usersTableView.reloadData()
	}
}

// MARK: - ErrorPresentable
extension UsersView: ErrorPresentable { }
