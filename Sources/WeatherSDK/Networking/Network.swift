import Foundation

final class Network {
    static func fetchData<T: Decodable>(from urlString: String, as type: T.Type) async throws -> T {
        let data = try await NetworkHandler.shared.fetch(from: urlString)
        return try DataDecoder.decode(data, as: type)
    }
}
