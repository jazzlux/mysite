//
//  File.swift
//  
//
//  Created by Piotr on 05/09/2020.
//

import Vapor

struct UserAuthenticator: BasicAuthenticator{
    
    typealias User = App.User
    
    func authenticate(basic: BasicAuthorization, for request: Request) -> EventLoopFuture<Void> {
        if basic.username == "test" && basic.password == "secret" {
            request.auth.login(User(name: basic.username))
        }
     
        return request.eventLoop.makeSucceededFuture(())
    }
}
