import Foundation
import Vapor

/// Streams generated reports back to the caller.
struct ReportController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        routes.get("report", use: fetch)
    }

    // CWE-22 - Path Traversal. The "name" query parameter is appended to the
    // report directory unchecked, so "../" reads files outside it.
    func fetch(req: Request) throws -> String {
        // SOURCE - attacker controlled query parameter
        let reportName = try req.query.get(String.self, at: "name")

        let path = "/var/reports/" + reportName

        // SINK
        guard let data = FileManager.default.contents(atPath: path) else {
            throw Abort(.notFound)
        }
        return String(decoding: data, as: UTF8.self)
    }
}
