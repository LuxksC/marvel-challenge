import Foundation
import Alamofire

struct EventsRequest: URLRequestProtocol {
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var baseURL: String {
        return "\(Environment.baseURL)/\(id)/events"
    }
    
    var path: [String: String] {
        
        let timestamp = NSDate().timeIntervalSince1970.description
        
        return [
            "ts": timestamp,
            "apikey": Environment.publicKey,
            "hash": hashMD5(timestamp: timestamp)
        ]
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
