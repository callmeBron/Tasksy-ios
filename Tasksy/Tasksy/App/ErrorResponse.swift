import Foundation

struct ErrorResponse: Error {
    let errorReason: String
    let errorMessage: String
}
