import Vapor
import Fluent


struct Registration : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        
        let registration = routes.grouped("register")
        registration.post(use: registerNewUser)
//        registration.post(use: checkHeader)
        
    }
    
    
    func registerNewUser(req : Request) throws -> EventLoopFuture<UserRegistry> {
        let register = try req.content.decode(UserRegistry.self)
//        let digest = SHA256.hash(data: Data(check.password.utf8))
        
        return register.save(on: req.db).map { register }
    }
    
    
    func checkHeader(req: Request) throws -> HTTPStatus {
        let check = try req.content.decode(NewUser.self)
        let digest = SHA256.hash(data: Data(check.password.utf8))

        return .ok
        
    }
    
}

