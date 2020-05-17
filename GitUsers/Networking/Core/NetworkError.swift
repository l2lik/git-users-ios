//
//  NetworkError.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case badInput
	case noData
	case parseError
	case unauthorized
	case authorizationAttemptsLimit
	case unknown
}

extension NetworkError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .authorizationAttemptsLimit, .unauthorized: return "Unauthorized request"
		default: return "Something went wrong"
		}
	}
}
