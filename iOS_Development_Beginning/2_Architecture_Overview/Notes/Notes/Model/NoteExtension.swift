import Foundation
import UIKit

extension Note {
    
    var json: [String: Any] {
        var result: [String: Any] = [:]
        
        result["uid"] = uid
        result["title"] = title
        result["content"] = content
        
        if color != .white {
            let colorDict = color.getRgbaDict()
            result["color"] = colorDict
        }
        
        switch importance {
        case .usual:
            break
        case .insignificant, .critical:
            result["importance"] = importance.rawValue
        }
        
        if let selfDestructionDate = selfDestructionDate {
            let timeInterval = selfDestructionDate.timeIntervalSince1970
            result["selfDestructionDate"] = timeInterval
        }
        
        return result
    }
    
    static func parse(json: [String: Any]) -> Note? {
        var note: Note?
        
        var selfDestructionDate: Date?
        if let timeInterval =  json["selfDestructionDate"] as? TimeInterval {
            selfDestructionDate = Date(timeIntervalSince1970: timeInterval)
        }
        
        var importance: Importance
        if let importanceRaw = json["importance"] as? String,
            let importanceParsed = Importance(rawValue: importanceRaw) {
            importance = importanceParsed
        } else {
            importance = .usual
        }
        
        if let title = json["title"] as? String,
            let content = json["content"] as? String,
            let uid = json["uid"] as? String {
            
            if let colorDict = json["color"] as? [String: Any] {
                let color = UIColor.getColor(from: colorDict)
                note = Note(uid: uid, title: title, content: content, color: color, importance: importance, selfDestructionDate: selfDestructionDate)
            } else {
                note = Note(uid: uid, title: title, content: content, importance: importance, selfDestructionDate: selfDestructionDate)
            }
        }
        
        return note
    }
}

extension UIColor {
    
    func getRgbaDict() -> [String: Double] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return ["red": Double(red), "green": Double(green), "blue": Double(blue), "alpha": Double(alpha)]
    }
    
    static func getColor(from rgbaDict: [String: Any]) -> UIColor {
        guard let red = rgbaDict["red"] as? Double,
            let green = rgbaDict["green"] as? Double,
            let blue = rgbaDict["blue"] as? Double,
            let alpha = rgbaDict["alpha"] as? Double else {
                return UIColor.white
        }
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}

