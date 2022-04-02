import Foundation

class EventsViewModel {
    
    private(set) var events: [ComicsItem]
    
    init(events: [ComicsItem]) {
        self.events = events
    }
}
