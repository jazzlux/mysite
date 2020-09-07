import Fluent
import FluentPostgresDriver
import FluentSQLiteDriver
import Vapor
import Leaf
import JWT

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    app.passwords.use(.bcrypt)

//    app.databases.use(.postgres(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//    ), as: .psql)
    
    // Configure Leaf
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    
    
    guard let secretKey = Environment.process.SECRET_KEY else {
        fatalError("can't find secret key")
    }
    
    
    app.jwt.signers.use(.hs256(key: secretKey))
    
    app.migrations.add(CreateUserRegistry())
    try app.autoMigrate().wait()
    
    app.migrations.add(CreateTodo())
    try app.autoMigrate().wait()


    // register routes
    try routes(app)
}
