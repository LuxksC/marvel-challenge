import Foundation
import UIKit

protocol EventsViewModelDelegate: AnyObject {
    
    func eventsFetchWithSucess()
    func errorToFetchEvents(_ error: String)
    
}
