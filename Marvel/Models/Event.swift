import Foundation
import SwiftUI

struct Events: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: EventData
}

struct EventData: Codable {
    let offset, limit, total, count: Int
    let results: [Event]
}

struct Event: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let thumbnail: Thumbnail?
}
