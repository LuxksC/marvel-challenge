import Foundation

enum HomeRequest: URLRequestProtocol {
	
	case home
	case details
	
	var baseURL: String {
		return Environment.baseURL
	}
	
	var path: String {
		
		let timestamp = NSDate().timeIntervalSince1970.description
		
		switch self {
		case .home:
			return "limit=10&ts=\(timestamp)&apikey=\(Environment.publicKey)&hash=\(hashMD5(timestamp: timestamp))"
		case .details:
			return "details=423432424"
		}
		
	}
	
	var method: HTTPMethod {
			return .get
	}
	
}
