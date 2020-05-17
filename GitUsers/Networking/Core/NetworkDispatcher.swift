//
//  NetworkDispatcher.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
  var environment: NetworkEnvironment { get }
	
  init(environment: NetworkEnvironment)
	
  func execute(request: NetworkRequest, completion: @escaping (NetworkResponse) -> Void)
}

