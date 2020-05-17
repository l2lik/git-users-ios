//
//  DefaultNetworkDispatcher.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 16.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

class DefaultNetworkDispatcher: NetworkDispatcher {
	let environment: NetworkEnvironment
	
	private let session: URLSession = URLSession(configuration: .default)
	private var task: URLSessionTask?
	
	required init(environment: NetworkEnvironment) {
		self.environment = environment
	}
	
	func execute(request: NetworkRequest, completion: @escaping (NetworkResponse) -> Void) {
		task?.cancel()
		
		if var urlComponents = URLComponents(string: environment.host + request.path) {
			if let parameters = request.parameters {
				urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: String(describing: $1)) }
			}
			
			guard let url = urlComponents.url else {
				return
			}
			
			var urlRequest = URLRequest(url: url)
			urlRequest.httpMethod = request.method.rawValue
			
			for (header, value) in environment.headers {
				urlRequest.addValue(value, forHTTPHeaderField: header)
			}
			
			if let requestHeaders = request.headers {
				for (header, value) in requestHeaders {
					urlRequest.addValue(value, forHTTPHeaderField: header)
				}
			}
			
			print("""
				\(urlRequest.httpMethod) \(urlRequest.debugDescription)
				Headers:
				\(urlRequest.allHTTPHeaderFields)
				""")
			
			task = session.dataTask(with: urlRequest, completionHandler: { [weak self, request] (data, response, error) in
				defer {
					self?.task = nil
				}
				
				print(response.debugDescription)
				
				let response = NetworkResponse((data: data, response: response, error: error), for: request)
				
				DispatchQueue.main.async {
					completion(response)
				}
			})
			
			task?.resume()
		}
	}
}
