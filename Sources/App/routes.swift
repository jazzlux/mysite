import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {
    
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

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
//    app.get("index") { req in
//        req.view.render("index", [
//            "title": "Hi",
//            "body": "Hello world!",
//            "ilosc": "3"
//        ])
//    }

    try app.register(collection: TodoController())
}
