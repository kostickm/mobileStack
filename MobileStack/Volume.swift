import UIKit

struct Volume {
    var name: String?
    var id: String?
    var status: String?
    
    init(name: String?, id: String?, status: String?) {
        self.name = name
        self.id = id
        self.status = status
    }
}
