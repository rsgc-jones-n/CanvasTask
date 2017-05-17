import Foundation

public class LindenmayerSystem {
    // Set up required information
    var angle : Degrees                 // rotation amount for turtle (degrees)
    var axiom : String
    var rule : [Character : String]
    var n : Int                         // number of times the production rule is applied
    var word : [String] = []            // the word that will be rendered
    // is rendered with an animation, step by step
    
    public init(angle : Degrees,
                axiom : String,
                rule : [Character : String],
                generations : Int) {
        
        // Initialize stored properties
        self.angle = angle
        self.axiom = axiom
        self.rule = rule
        self.n = generations
        self.word.append(axiom)   // The first word is the axiom
        
        // Apply the production rule
        applyRules()
        
    }
    
    public init(with system : LindenmayerSystem) {
        
        // Initalize stored properties
        self.angle = system.angle
        self.axiom = system.axiom
        self.rule = system.rule
        self.n = system.n
        self.word.append(axiom)   // The first word is the axiom
        
        // Apply the production rule
        applyRules()
    }
    
    func applyRules() {
        
        // See if word needs to be re-written
        if n > 0 {
            
            // Apply the production rule "n" times
            for i in 1...n {
                
                // Create a new word
                var newWord = ""
                
                // Inspect each character of existing word
                for character in word[i - 1].characters {
                    
                    
                    switch character {
                        
                    case "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" :
                        
                        if let successor = rule[character] {
                            newWord.append(successor)
                        }
                        
                    default:
                        
                        newWord.append(character)
                        
                    }
                    
                }
                
                
                // Add the re-written word to the system
                word.append(newWord)
                
            }
            
        }
        
    }
    
}
