class Car {
    
    struct Go {
        
        let direction: Direction
        
        let amount: Double
    }
    
    struct Location {
        
        var x: Double
        
        var y: Double
    }
    
    enum Direction {
        
        case forward
        
        case backward
        
        case left
        
        case right
    }
    
    let make: String
    
    let color: UIColor
    
    let name: String
    
    let maxSpeed: Double
    
    let numberOfDoors: Int
    
    var location: Location
    
    init(make: String, color: UIColor, name: String, maxSpeed: Double, numberOfDoors: Int, location: Location) {
        self.make = make
        self.color = color
        self.name = name
        self.maxSpeed = maxSpeed
        self.numberOfDoors = numberOfDoors
        self.location = location
    }
    
    func move(direction: Direction, amount: Double) {
        switch direction {
        case .backward:
            location.y -= amount
        case .forward:
            location.y += amount
        case .left:
            location.x -= amount
        case .right:
            location.x += amount
        }
    }
    
    func execute(command: Go) {
        move(direction: command.direction, amount: command.amount)
    }
}
