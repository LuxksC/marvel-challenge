import Foundation

enum HTTPError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}
