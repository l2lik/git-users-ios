//
//  NetworkOperation.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

protocol NetworkOperation {
	associatedtype Output: Codable

	var request: NetworkRequest { get }
	
	func execute(in dispatcher: NetworkDispatcher, completion: @escaping (Result<Output, NetworkError>) -> Void)
}

extension NetworkOperation {
	func execute(in dispatcher: NetworkDispatcher, completion: @escaping (Result<Output, NetworkError>) -> Void) {
		dispatcher.execute(request: request) { response in
			switch response {
			case .json(let data):
				do {
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .iso8601
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let responseObject = try decoder.decode(Output.self, from: data)
					
					completion(.success(responseObject))
				} catch {
					completion(.failure(.parseError))
				}
			case .error(let error):
				completion(.failure(error))
			}
		}
	}
}
