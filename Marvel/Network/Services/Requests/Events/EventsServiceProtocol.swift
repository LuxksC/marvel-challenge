import Foundation

enum EventsError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}

protocol EventsServiceProtocol: AnyObject {
    
    func fetchEvents(heroId: Int, completion: @escaping(Result<Events, EventsError>) -> Void)
    
}
