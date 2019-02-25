import Vapor
import FluentSQLite

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // Basic POST example
    router.post(Dish.self, at: "api/dish") { request, dish -> Future<Dish> in
        return dish.save(on: request)
    }
    
    // Basic GET example
    router.get("api/dishes") { request -> Future<[Dish]> in

        return Dish.query(on: request).all()
    }
    
    // Basic GET by id example
    router.get("api/dish", Dish.parameter) { request -> Future<Dish> in
        
        return try request.parameters.next(Dish.self)
    }
    
    // Basic GET by property example
    router.get("api/dishes", String.parameter) { request -> Future<[Dish]> in
        
        let course = try request.parameters.next(String.self).lowercased()
        return Dish.query(on: request).filter(\.course == course).all()
    }
    
    // Basic DELETE example
    router.delete("api/dish", Dish.parameter) { request -> Future<Dish> in
        return try request.parameters.next(Dish.self).delete(on: request)
    }
}
