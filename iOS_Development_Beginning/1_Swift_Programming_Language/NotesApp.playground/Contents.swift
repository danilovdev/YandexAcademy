import UIKit

struct Note {
    
    enum Importance {
        
        case unimportant
        
        case ordinary
        
        case important
    }
    
    let uid: String
    
    let title: String
    
    let content: String
    
    let color: UIColor
    
    let importance: Importance
    
    let selfDestructionDate: Date?
    
    init(title: String, content: String, importance: Importance) {
        self.init(uid: nil, title: title, content: content, color: nil, importance: importance)
    }
    
    init(uid: String, title: String, content: String, importance: Importance) {
        self.init(uid: uid, title: title, content: content, color: nil, importance: importance)
    }
    
    init(uid: String, title: String, content: String, importance: Importance, color: UIColor) {
        self.init(uid: uid, title: title, content: content, color: color, importance: importance)
    }
    
    init(uid: String, title: String, content: String, importance: Importance, color: UIColor, selfDestructionDate: Date) {
        self.init(uid: uid, title: title, content: content, color: color, importance: importance, selfDestructionDate: selfDestructionDate)
    }
    
    private init(uid: String?, title: String, content: String, color: UIColor?, importance: Importance, selfDestructionDate: Date? = nil) {
        self.uid = (uid != nil) ? uid! : UUID().uuidString
        self.title = title
        self.content = content
        self.color = (color != nil) ? color! : UIColor.white
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }
}

