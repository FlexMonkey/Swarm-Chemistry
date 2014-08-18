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
 
    
    override init()
    {
        super.init();
    }
    
    required init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder);
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
    }
    
    init(genome : SwarmGenome)
    {
        super.init();
        
        self.genome = genome;
        
        color = genome.color;
        size = CGSize(width: 2, height: 2);
    }
}
