import Foundation

public struct NetworkClient {
    public init() {}
}

extension NetworkClient: HTTPClient {
    public func request(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        NetworkLogger.logger.logRequest(request)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NetworkLogger.logger.logError(request, error: error as NSError)
                completion(.failure(.network(error)))
                return
            }
            NetworkLogger.logger.logResponse(response, method: request.httpMethod ?? "", data: data)

            guard let data = data else {
                //let error = NetworkError(errorCode: ErrorCode.badRequest)
                completion(.failure(.invalidData))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }

    public func request(_ request: HTTPRequest, completion: @escaping (Result<Data, NetworkError>) -> Void ) {
        guard let urlRequest = request.urlRequest else {
            let error = NSError(domain: "URL is not properly formatted", code: -1, userInfo: nil)
            completion(.failure(.network(error)))
            return
        }
        self.request(urlRequest, completion: completion)
    }
}
