import Foundation
import Vapor

/// Serves documents out of the upload directory.
struct FileController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        routes.get("download", use: download)
    }

    // CWE-22 - Path Traversal. The "file" query parameter is joined onto a base
    // directory without normalisation, so "../" escapes the upload root.
    func download(req: Request) throws -> String {
        // SOURCE - attacker controlled query parameter
        let fileName = try req.query.get(String.self, at: "file")

        let path = "/var/www/uploads/" + fileName

        // SINK
        return try String(contentsOfFile: path, encoding: .utf8)
    }
}
