//
//  VisualizedLindenmayerSystem.swift
//  Canvas
//
//  Created by Russell Gordon on 5/3/17.
//  Copyright © 2017 Royal St. George's College. All rights reserved.
//

import Foundation

public class VisualizedLindenmayerSystem : LindenmayerSystem {
    
    public struct stateOfSystem {
        var systemX : Float
        var systemY : Float
        var systemAngle : Degrees
        
        public init(systemX: Float, systemY: Float, systemAngle: Degrees) {
            
            self.systemX = systemX
            self.systemY = systemY
            self.systemAngle = systemAngle
        }
        
    }
    
    var initialLength : Float               // initial line segment length
    var reduction : Float                   // reduction factor
    var x : Float                           // initial horizontal position of turtle
    var y : Float                           // initial vertical position of turtle
    var direction : Int                     // initial direction turtle faces (degrees)
    var currentLength : Float               // current line segment length
    var currentAngle : Degrees              // current angle measurement
    var animationPosition = 0               // tracks current character being interpreted when system is animated
    var systemStack = [stateOfSystem]()     // tracks system locations
    var colours : [String : Colour]         // tracks colours of system

    public init(with providedSystem: LindenmayerSystem,
                length: Float,
                reduction: Float,
                x: Float,
                y: Float,
                direction: Int,
                colours : [String : Colour]) {
        
        // Initialize stored properties
        self.initialLength = length
        self.reduction = reduction
        self.x = x
        self.y = y
        self.direction = direction
        self.currentLength = self.initialLength
        self.currentAngle = Degrees(direction)
        
        self.colours = colours
        
        super.init(with: providedSystem)
        
    }
    

}
