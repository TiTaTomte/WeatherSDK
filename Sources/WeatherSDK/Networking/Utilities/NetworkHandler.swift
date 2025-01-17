import Foundation

actor NetworkHandler {
    private let cache = NSCache<NSString, NSData>()
    static let shared = NetworkHandler()
    private init() {}

    func fetch(from urlString: String) async throws -> Data {
        if let cachedData = cache.object(forKey: NSString(string: urlString)) {
            return cachedData as Data
        }

        guard let url = URL(string: urlString) else {
            throw CustomError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw CustomError.invalidResponse
            }
            
            cache.setObject(data as NSData, forKey: NSString(string: urlString))

            return data
        } catch {
            throw CustomError.requestFailed(error)
        }
    }
}
