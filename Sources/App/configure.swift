import Vapor

/// Boots the application and registers every route collection.
public func configure(_ app: Application) throws {
    try app.register(collection: FileController())
    try app.register(collection: UserController())
}
