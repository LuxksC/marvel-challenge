import Foundation
import Alamofire

enum HomeRequest: URLRequestProtocol {
    
    case home
    
    var baseURL: String {
        return Environment.baseURL
    }
    
    var path: [String: String] {
        
        let timestamp = NSDate().timeIntervalSince1970.description
        
        return [
            "limit": "10",
            "ts": timestamp,
            "apikey": Environment.publicKey,
            "hash": hashMD5(timestamp: timestamp)
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
