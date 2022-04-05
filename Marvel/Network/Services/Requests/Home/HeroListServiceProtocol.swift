import Foundation

enum HeroError: Error {
	case error(String)
	case urlInvalid
	case noDataAvailable
	case noProcessData
}

protocol HeroListServiceProtocol: AnyObject {
	
	func execute(handler: @escaping(Result<Response, HeroError>) -> Void)
	
}
