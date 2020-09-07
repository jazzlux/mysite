import Vapor
import Fluent



final class UserRegistry: Model, Content {
    
    static let schema = "userRegistry"
    
    @ID(key: .id)
    var id : UUID?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password")
    var password: String
    
    init() { }
    
    init(id: UUID? = nil, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
    
    
}



