//
//  NetworkEnvironment.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 16.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

protocol NetworkEnvironment {
	var host: String { get }
	var headers: [String: String] { get }
	var apiKey: String? { get }
	var cachePolicy: URLRequest.CachePolicy { get }
}

// MARK: - Default values
extension NetworkEnvironment {
	public var headers: [String: String] {
		return [:]
	}
	
	var apiKey: String? { return nil }
	
	public var cachePolicy: URLRequest.CachePolicy {
		return .reloadIgnoringLocalAndRemoteCacheData
	}
}
