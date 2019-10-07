//
//  UserController.swift
//  App
//
//  Created by Jean-Paul REMAN on 06/10/2019.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class UserController {
    
    func index(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request, user: User) throws -> Future<User> { 
        return user.save(on: req)
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
        }.transform(to: .ok)
    }
    
    
}
