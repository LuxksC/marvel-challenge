import Foundation
import UIKit

extension UIImageView {
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 50
        self.clipsToBounds = true
    }
}
