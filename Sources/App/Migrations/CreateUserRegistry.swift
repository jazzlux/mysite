import Vapor
import Fluent


struct CreateUserRegistry : Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("userRegistry").id().field("email", .string, .required).field("password", .string, .required).create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("userRegistry").delete()
    }
    
    
}
