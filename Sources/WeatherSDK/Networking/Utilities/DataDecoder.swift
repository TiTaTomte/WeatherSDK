import Foundation

final class DataDecoder {
    static func decode<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw CustomError.decodingFailed(error)
        }
    }
}
