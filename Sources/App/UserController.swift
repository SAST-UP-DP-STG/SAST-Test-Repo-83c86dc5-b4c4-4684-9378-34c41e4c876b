import Foundation
import SQLite3
import Vapor

/// Looks up users by identifier.
struct UserController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        routes.get("user", use: find)
    }

    // CWE-89 - SQL Injection. The "id" query parameter is concatenated straight
    // into the statement text instead of being bound as a parameter.
    func find(req: Request) throws -> String {
        // SOURCE - attacker controlled query parameter
        let userId = try req.query.get(String.self, at: "id")

        var db: OpaquePointer?
        sqlite3_open(ProcessInfo.processInfo.environment["DB_PATH"], &db)

        let query = "SELECT id, name, email FROM users WHERE id = " + userId

        var statement: OpaquePointer?
        // SINK
        sqlite3_prepare_v2(db, query, -1, &statement, nil)
        sqlite3_step(statement)
        sqlite3_finalize(statement)
        sqlite3_close(db)

        return "ok"
    }
}
