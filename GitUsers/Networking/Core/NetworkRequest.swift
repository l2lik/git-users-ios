//
//  Request.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

protocol NetworkRequest {
	var path: String { get }
	var method: HTTPMethod { get }
	var parameters: [String: Any]? { get }
	var headers: [String: String]? { get }
	var dataType: DataType { get }
}

// MARK: - Default values
extension NetworkRequest {
	public var parameters: [String: Any]? {
		return nil
	}
	
	public var headers: [String: String]? {
		return nil
	}
	
	public var dataType: DataType {
		return .json
	}
}

enum HTTPMethod: String {
	case post = "POST"
	case put = "PUT"
	case get = "GET"
	case delete = "DELETE"
	case patch = "PATCH"
}

public enum DataType {
	case json
}
