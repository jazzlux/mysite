import Vapor
import Fluent

struct NewUser: Authenticatable, Content {
    var name: String
    var isAdmin: Bool?
    var email: String
    var password: String
    
}


