import Foundation

protocol HeroListServiceProtocol: AnyObject {
	
	func execute(completion: @escaping(Result<Response, HTTPError>) -> Void)
	
}
