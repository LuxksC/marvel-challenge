import Foundation

class EventsViewModel {
    
    private(set) var name: String
    private(set) var id: Int
    
    private var services: EventsServiceProtocol
    
    weak var delegate: EventsViewModelDelegate?
    
    var events: [Event] = []
    
    init(name: String, id: Int, services: EventsServiceProtocol) {
        self.name = name
        self.id = id
        self.services = services
    }
    
    func fetchEvents() {
        
        services.fetchEvents(heroId: self.id) { result in
            switch result {
            case .success(let events):
                self.sucess(events: events)
            case .failure(let error):
                self.error(error: error.localizedDescription)
            }
        }
    }
    
    private func sucess(events: Events) {
        self.events = events.data.results
        delegate?.eventsFetchWithSucess()
    }
    
    private func error(error: String) {
        delegate?.errorToFetchEvents(error)
    }
}
