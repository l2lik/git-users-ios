//
//  Response.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

enum NetworkResponse {
	case json(Data)
	case error(NetworkError)
	
	init(_ response: (data: Data?, response: URLResponse?, error: Error?), for request: NetworkRequest) {		
		if let error = response.error {
			self = .error(.unknown)
			return
		}
		
		if let r = response.response as? HTTPURLResponse {
			if r.statusCode == 401 {
				self = .error(.unauthorized)
				return
			}
			
			if r.statusCode == 403 {
				self = .error(.authorizationAttemptsLimit)
				return
			}
			
			if !(200..<300).contains(r.statusCode) {
				self = .error(.unknown)
				return
			}
		}
		
		guard let data = response.data else {
			self = .error(.noData)
			return
		}
		
		switch request.dataType {
		case .json:
			self = .json(data)
		}
	}
}
