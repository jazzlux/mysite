import Fluent
import Vapor
import Leaf
import AuthenticationServices

func routes(_ app: Application) throws {
    
//MARK: Leaf tests
    
//    struct Item: Codable {
//        var title: String
//        var description: String
//    }
//
//
//    app.get("users") { req -> EventLoopFuture<View> in
//
//        struct Context: Codable {
//            let items: [Item]
//        }
//
//        let context = Context(items: [
//            .init(title: "#01", description: "Description #01"),
//            .init(title: "#02", description: "Description #02"),
//            .init(title: "#03", description: "Description #03"),
//
//        ])
//
//
//        return req.view.render("index", context)
//    }
    
    
    app.get("text") { req in
         req.view.render("text", [
             "title": "o mnie",
             "description": "This is my own page.",
             "content": "dziele sie o mnie..."
         ])
     }
     
    
    
    app.get { req in
        return "It works!"
    }
    
//MARK: auth tests
    
    
    let securityTest = app.grouped(UserAuthenticator())
    
    securityTest.get("protected") { req -> String in
        try req.auth.require(User.self).name
    }
    
    securityTest.get("notprotected") { req -> String in
        return "nonprotected route"
        
    }
    
    let beerUser = app.grouped(BeerAuthenticator())
    beerUser.get("beerUser") { req -> String in
        try req.auth.require(User.self).name
    }
    
    
    app.get("jwtTest") { req -> HTTPStatus in
        let payload = try req.jwt.verify(as: TestPayload.self)
        print(payload)
        
        return .accepted
    }
    
    
    // Generate and return a new JWT.
    app.post("login") { req -> [String: String] in
        // Create a new instance of our JWTPayload
        let payload = TestPayload(
            subject: "vapor",
            expiration: .init(value: .distantFuture),
            isAdmin: true
        )
        print(try req.jwt.sign(payload))
        // Return the signed JWT
        return try [
            "token": req.jwt.sign(payload)
        ]
    }
    
    
//    MARK: Group with jwt auth
    
    let verySecureRoute = app.grouped(TestPayload.authenticator(), TestPayload.guardMiddleware())
    
    verySecureRoute.get("verySecure") { req -> HTTPStatus in
        let user = try req.auth.require(TestPayload.self)
        print(user.isAdmin)
        return .ok
    }
    
    try app.register(collection: TodoController())
}
