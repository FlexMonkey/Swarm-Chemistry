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
    let swarmMemberArray : NSMutableArray;
    let startIndex : Int;
    let sampleSize : Int;
    
    init(swarmMemberArray : NSMutableArray, startIndex : Int, sampleSize : Int)
    {
        self.swarmMemberArray = swarmMemberArray;
        self.startIndex = startIndex;
        self.sampleSize = sampleSize;
        
        super.init();
    }
    
    override public func main() -> ()
    {
        let n = startIndex + sampleSize;
        
        for var i : Int = startIndex; i < n; i++
        {
            let swarmMember : SwarmMember = swarmMemberArray[i] as SwarmMember;
            
            swarmMember.position.x = CGFloat(swarmMember.position.x) + CGFloat(1);
            
            if swarmMember.position.x > 1024
            {
                swarmMember.position.x = 1; 
            }
        }
    }
}
