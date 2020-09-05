import Vapor
import JWT

struct TestPayload: JWTPayload, Authenticatable {
    
    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case isAdmin = "admin"
    }
    
    var subject : SubjectClaim
    var expiration : ExpirationClaim
    var isAdmin : Bool
    
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
    
    
    
}
