import Foundation
import UIKit

struct Note: Equatable {
    
    enum Importance: String, Equatable {
        
        case insignificant
        
        case usual
        
        case critical
    }
    
    let uid: String
    
    var title: String
    
    var content: String
    
    var color: UIColor
    
    var importance: Importance
    
    var selfDestructionDate: Date?
    
    init(uid: String = UUID().uuidString,
         title: String,
         content: String,
         color: UIColor = .white,
         importance: Importance,
         selfDestructionDate: Date? = nil) {
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }
}
