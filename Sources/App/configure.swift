import FluentSQLite
import FluentPostgreSQL
import Vapor

// in this file
// add the import of FluentPostgresSQL
// Regiter the FluentPostgresSQLProvider
// create the databaseConfig object
// create the database
// migration of the model

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    // configure a postgres database
    let databaseConfig = PostgreSQLDatabaseConfig(
        hostname: "localhost", username: "postgres", database: "nootim")
    
    let database = PostgreSQLDatabase(config: databaseConfig)
    
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: database, as: .psql)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql)
    migrations.add(migration: AddBirthdateToUser.self, database: .psql) // changes to datbase after creation
    services.register(migrations)
}
