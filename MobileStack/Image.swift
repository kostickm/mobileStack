import UIKit

struct Image {
    var name: String?
    var id: String?
    var createdAt: String?
    
    init(name: String?, id: String?, createdAt: String?) {
        self.name = name
        self.id = id
        self.createdAt = createdAt
    }
}
