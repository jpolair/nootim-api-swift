//
//  AddBirthdateToUser.swift
//  App
//
//  Created by Jean-Paul REMAN on 06/10/2019.
//

import Foundation
import Vapor
import FluentPostgreSQL

class AddBirthdateToUser: Migration {
    typealias Database = PostgreSQLDatabase
    
    static func prepare(on conn: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return Database.update(User.self, on: conn) { builder in
            builder.field(for: \.birthdate)
        }
    }
    
    static func revert(on conn: PostgreSQLConnection) -> EventLoopFuture<Void> {
       return Database.update(User.self, on: conn) { builder in
           builder.deleteField(for: \.birthdate)
       }
    }
}
