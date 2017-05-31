import Foundation

public class EnhancedCanvas : Canvas {
    
    public func render(system s : VisualizedLindenmayerSystem) {
        
        render(system: s, generation: s.n)
        
    }
    
    public func render(system : VisualizedLindenmayerSystem, generation : Int) {
        
        // Make sure generation exists
        var generation = generation
        if generation > system.n {
            generation = system.n
        }
        
        // Edit line length
        system.currentLength = Float( Double(system.initialLength) / pow(Double(system.reduction), Double(generation)) )
        
        // Render word
        self.saveState()
        //self.translate(byX: system.x, byY: system.y)
        for c in system.word[generation].characters {
            interpret(character: c, forThis: system)
        }
        
        self.restoreState()
        
    }
    
    public func renderAnimated(system : [VisualizedLindenmayerSystem], generations : [Int]) {
        
        var i = 0
        var generation  = 0
        
        for sys in system {
            
            // Verify that generation that was asked to be rendered actually exists
            if generations.count > i {
                
                generation = generations[i]
                
            } else {
                
                generation = generations[generations.count - 1]
                
            }
            
            // Make sure generation exists
            if generation > sys.n {
                generation = sys.n
            }
            
            // Set starting variables
            if sys.animationPosition == 0 {
                
                // Set starting variables and apply reduction rules
                sys.currentLength = Float(Double(sys.initialLength) / pow(Double(sys.reduction), Double(generation)))

            }
            
            // Don't go past the last variable
            if sys.animationPosition < sys.word[generation].characters.count {
                
                // Nect character...
                let index = sys.word[generation].index(sys.word[generation].startIndex, offsetBy: sys.animationPosition)
                let c = sys.word[generation][index]
                interpret(character: c, forThis: sys)
                
                // Next character...
                sys.animationPosition += 1
                
            }
            
            // Add a loop
            i += 1
            
        }
        
    }
    
    func interpret(character : Character, forThis system : VisualizedLindenmayerSystem) {
        
        let newX: Float = Float(CGFloat(system.x)) + Float(CGFloat(system.currentLength) * CGFloat(cos(system.currentAngle * CGFloat(M_PI)/180)))
        let newY: Float = Float(CGFloat(system.y)) + Float(CGFloat(system.currentLength) * CGFloat(sin(system.currentAngle * CGFloat(M_PI)/180)))
        
        // Interpret each character of the word
        switch character {
            
            // Case uppercase latter
        case "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X",  "Y", "Z" :
            // Draw a line
            self.drawLine(fromX: system.x, fromY: system.y, toX: newX, toY: newY)
            system.x = newX
            system.y = newY
        case "f":
            // Move forward
            system.x = newX
            system.y = newY
        case "+":
            // Left
            system.currentAngle += system.angle
        case "-":
            // Right
            system.currentAngle -= system.angle
        case "[":
            // Save!
            system.systemStack.append(VisualizedLindenmayerSystem.stateOfSystem(systemX: system.x, systemY: system.y, systemAngle: system.currentAngle))
        case "]":
            // Remember!
            system.x = system.systemStack[system.systemStack.count - 1].systemX
            system.y = system.systemStack[system.systemStack.count - 1].systemY
            system.currentAngle = system.systemStack[system.systemStack.count - 1].systemAngle
            system.systemStack.removeLast()
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" :
            // Change colour
            let setColour = Color(hue: system.colours[String(character)]!.hue, saturation: system.colours[String(character)]!.saturation, brightness: system.colours[String(character)]!.brightness, alpha: 100)
            self.lineColor = setColour
        default:
            break
            
        }
        
    }
    
}
