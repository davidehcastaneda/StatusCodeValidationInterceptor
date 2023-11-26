import NetworkClient
import Foundation

class StatusCodeValidationInterceptor: Interceptor {
    public init(){
    }

    public func intercept(request: Request, chain: Chain) async throws -> (Data, URLResponse) {
        let response = try await chain.proceed(request: request)
        try validateHttpStatusCodes(from: response.1)
        return response
    }

    private func validateHttpStatusCodes(from response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else { throw ResponseValidatorInterceptorErrors.responseIsNotHttp }
        let statusCode = response.statusCode
        guard statusCode >= 200 else { throw ResponseValidatorInterceptorErrors.noInfoAvailable(response) }
        guard statusCode < 500 else { throw ResponseValidatorInterceptorErrors.apiError(response) }
        guard statusCode < 400 else { throw ResponseValidatorInterceptorErrors.requestError(response) }
    }

    private enum ResponseValidatorInterceptorErrors: Error {
        case responseIsNotHttp
        case noInfoAvailable(CustomStringConvertible)
        case apiError(CustomStringConvertible)
        case requestError(CustomStringConvertible)
    }
}
