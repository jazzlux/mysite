import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("index") { req in
        req.view.render("index", [
            "title": "Hi",
            "body": "Hello world!",
            "ilosc": "3"
        ])
    }

    try app.register(collection: TodoController())
}
