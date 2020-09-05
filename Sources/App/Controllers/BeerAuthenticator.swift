import Vapor

struct BeerAuthenticator: BearerAuthenticator {
    typealias User = App.User
    
    func authenticate(bearer: BearerAuthorization, for request: Request) -> EventLoopFuture<Void> {
        if bearer.token == "foo" {
            request.auth.login(User(name: "PioAdmin"))
        }
        return request.eventLoop.makeSucceededFuture(())
    }
}
