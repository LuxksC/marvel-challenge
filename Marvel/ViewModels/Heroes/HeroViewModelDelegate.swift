import Foundation
import UIKit

protocol HeroViewModelDelegate: AnyObject {
	
	func heroFetchWithSucess()
	func errorToFetchHero(_ error: String)
	
}
