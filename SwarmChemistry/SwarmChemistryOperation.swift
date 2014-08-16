//
//  SwarmChemistryOperation.swift
//  SwarmChemistry
//
//  Created by Simon Gladman on 16/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation
import SpriteKit

public class SwarmChemistryOperation : NSOperation
{
    var swarmMemberArray : NSMutableArray = NSMutableArray(capacity: 1000);
    
    init(swarmMemberArray : NSMutableArray)
    {
        super.init();
        
        self.swarmMemberArray = swarmMemberArray;
    }
    
    override public func main() -> ()
    {
        for i in 0..<1000
        {
            let foo : SwarmMember = swarmMemberArray[i] as SwarmMember;
            
            foo.position.x = CGFloat(foo.position.x) + CGFloat(1);
        }
    }
}
