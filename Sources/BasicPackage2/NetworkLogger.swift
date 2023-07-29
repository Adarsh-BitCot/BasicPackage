
import Foundation

public struct NetworkLogger {
    public static var logger = NetworkLogger(logLevel: .debug)
    private(set) public var logLevel: LogLevel

    private init(logLevel: LogLevel) {
        self.logLevel = logLevel
    }

    public func log(_ string: String) {
        guard logLevel != .off else { return }
        print(string)
    }

    public mutating func set(logLevel: LogLevel) {
        self.logLevel = logLevel
    }
}

extension NetworkLogger {
    public enum LogLevel {
        case verbose, debug, off
    }
}

extension NetworkLogger {

    private func logNetworkCall(_ string: String) {
        log("[ \(string)]")
    }

    func logRequest(_ request: URLRequest) {
        guard logLevel != .off else { return }
        var s = "⬆️ "

        if let method = request.httpMethod {
            s += "\(method) "
        }

        if let url = request.url?.absoluteString {
            s += "'\(url)' "
        }

        if logLevel == .verbose,
            let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            s += "\n" + logHeaders(headers as [String: AnyObject])
            s += "\nBody: \(bodyString(request.httpBodyData))"
        }

        logNetworkCall(s)
    }

//    func logResponse(_ response: URLResponse?, method: String, data: Data? = nil) {
//        guard logLevel != .off else { return }
//        var s = "⬇️ \(method) '\(response?.url?.absoluteString ?? "")'"
//
//        if let httpResponse = response as? HTTPURLResponse {
//            s += "("
//            let iconNumber = Int(floor(Double(httpResponse.statusCode) / 100.0))
//            if let iconString = statusIcons[iconNumber] {
//                s += "\(iconString) "
//            }
//
//            s += "\(httpResponse.statusCode)"
//            if let statusString = ErrorCode(rawValue: httpResponse.statusCode) {
//                s += " \(statusString.defaultDisplayMessage)"
//            }
//            s += ")"
//        }
//
//        if logLevel == .verbose,
//            let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: AnyObject], !headers.isEmpty {
//            s += "\n" + logHeaders(headers)
//
//            s += "\nBody: \(bodyString(data))"
//        }
//
//        logNetworkCall(s)
//    }

    func logError(_ request: URLRequest, error: NSError) {
        guard logLevel != .off else { return }
        var s = "⚠️ \(request.httpMethod ?? "") '\(request.url?.absoluteString ?? "")'"

        s += "\nERROR: \(error.localizedDescription)"

        if let reason = error.localizedFailureReason {
            s += "\nReason: \(reason)"
        }

        if let suggestion = error.localizedRecoverySuggestion {
            s += "\nSuggestion: \(suggestion)"
        }

        logNetworkCall(s)
    }
}

private extension NetworkLogger {
    var statusIcons: [Int: String] {
        return [
            1: "ℹ️",
            2: "✅",
            3: "⤴️",
            4: "⛔️",
            5: "❌"
        ]
    }

    func logHeaders(_ headers: [String: AnyObject]) -> String {
        var s = "Headers: [\n"
        headers.forEach { s += "\t\t\($0.key) : \($0.value)\n" }
        s += "\t\t]"
        return s
    }

    func bodyString(_ body: Data?) -> String {
        guard let body = body else { return "nil" }
        if let json = try? JSONSerialization.jsonObject(with: body, options: .mutableContainers),
            let pretty = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
            let string = String(data: pretty, encoding: String.Encoding.utf8) {
            return string
        } else if let string = String(data: body, encoding: String.Encoding.utf8) {
            return string
        } else {
            return body.description
        }
    }
}

private extension URLRequest {
    var httpBodyData: Data? {

        guard let stream = httpBodyStream else {
            return httpBody
        }

        let data = NSMutableData()
        stream.open()
        let bufferSize = 4_096
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while stream.hasBytesAvailable {
            let bytesRead = stream.read(buffer, maxLength: bufferSize)
            if bytesRead > 0 {
                let readData = Data(bytes: UnsafePointer<UInt8>(buffer), count: bytesRead)
                data.append(readData)
            } else if bytesRead < 0 {
                print("error occured while reading HTTPBodyStream: \(bytesRead)")
            } else {
                break
            }
        }
        stream.close()
        return data as Data
    }
}
