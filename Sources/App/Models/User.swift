//
//  User.swift
//  App
//
//  Created by Jean-Paul REMAN on 06/10/2019.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class User: Content {
    
    var id: Int?
    var firstname: String
    var lastname: String
    var address: String
    var birthdate: String
    
    init(firstname: String, lastname: String, address: String, birthdate: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.address = address
        self.birthdate = birthdate
    }
}

extension User: PostgreSQLModel {
    // name of the table (model in plural is better than model singular)
    static var entity: String = "Users"
}

extension User: Migration {}

extension User: Parameter {}
