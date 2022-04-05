import Foundation

class HeroListService: HeroListServiceProtocol {
    func execute(completion: @escaping (Result<Response, HeroError>) -> Void) {
        let request = HomeRequest.home
        NetworkManager.shared.request(of: Response.self, request: request) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error as! HeroError))
            }
        }
    }
}
