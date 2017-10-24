//
//  Connector.swift
//  API
//
//  Created by Kristijan Delivuk on 24/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import Foundation
import Alamofire

public class Connector {

    let manager: SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [: ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        let authManager =  SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        return authManager
    }()
    
    public init() {
        
    }
}
