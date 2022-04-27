import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    public func request<T: Decodable>(of type: T.Type = T.self, request: URLRequestProtocol, completion: @escaping (Result<T, HTTPError>) -> Void) {
        
        AF.request(request.baseURL, method: request.method, parameters: request.path)
            .validate()
            .responseDecodable(of: type) { response in
        
                switch response.response?.statusCode {
                case 200:
                    guard let responseValue = response.value else { return }
                    completion(.success(responseValue))
                default:
                    completion(.failure(.error("Response code untracked")))
                    break
                }
            }
    }
    
}
