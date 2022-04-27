import Foundation

protocol EventsServiceProtocol: AnyObject {
    
    func fetchEvents(heroId: Int, completion: @escaping(Result<Events, HTTPError>) -> Void)
    
}
