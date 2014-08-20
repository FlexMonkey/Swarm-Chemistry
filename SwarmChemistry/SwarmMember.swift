//
//  SwarmMember.swift
//  SwarmChemistry
//
//  Created by Simon Gladman on 15/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation;
import SpriteKit;
import UIKit;

class SwarmMember : SKSpriteNode
{
    var genome : SwarmGenome?;
    
    var dx : Double = 0.0;
    var dy : Double = 0.0;
    
    var dx2 : Double = 0.0;
    var dy2 : Double = 0.0;
    
    var distance : Double = 0.0;
    
    override init()
    {
        super.init();
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init(genome : SwarmGenome)
    {
        super.init();
        
        self.genome = genome;
        
        color = genome.color;
        size = CGSize(width: 2, height: 2);
    }
    
    func move()
    {
        
        dx = dx2;
        dy = dy2;
        
        let targetX = CGFloat(Double(position.x) + dx);
        let targetY = CGFloat(Double(position.y) + dy);
        
        position = CGPoint(x: targetX, y: targetY);
        
        if (position.y < 0)
        {
            position.y = Constants.HEIGHT;
        }
        else if (position.y > Constants.HEIGHT)
        {
            position.y = 1;
        }
        
        if (position.x < 0)
        {
            position.x = Constants.WIDTH
        }
        else if (position.x > Constants.WIDTH)
        {
            position.x =  1;
        }
        
    }
    
    func accelerate(ax : Double, ay : Double, maxMove : Double)
    {
        dx2 += ax;
        dy2 += ay;
        
        var d : Double = dx2 * dx2 + dy2 * dy2;
        
        if (d > maxMove * maxMove)
        {
            var normalizationFactor : Double = maxMove / sqrt(d);
            dx2 *= normalizationFactor;
            dy2 *= normalizationFactor;
        }
    }
    
    
}
