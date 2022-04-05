import Foundation

class EventsService: EventsServiceProtocol {
    func fetchEvents(heroId: Int, completion: @escaping (Result<Events, EventsError>) -> Void) {
        let request = EventsRequest(id: heroId)
        NetworkManager.shared.request(of: Events.self, request: request) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error as! EventsError))
            }
        }
    }
    
    
}
