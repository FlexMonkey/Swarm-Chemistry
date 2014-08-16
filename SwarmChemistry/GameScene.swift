//
//  GameScene.swift
//  SwarmChemistry
//
//  Created by Simon Gladman on 15/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import SpriteKit

class GameScene: SKScene
{
    var swarmChemistryOperation : SwarmChemistryOperation?;
    
    var swarmMemberArray : NSMutableArray = NSMutableArray(capacity: 1000);
    let swarmMemberRange : Range<Int> = 0..<1000;
    
    let queue = NSOperationQueue();
    
    override func didMoveToView(view: SKView)
    {
        for i in swarmMemberRange
        {
            let swarmMember : SwarmMember = SwarmMember(color: UIColor.redColor(), size: CGSize(width: 2, height: 2));
            
            swarmMember.position = CGPoint(x: Int(rand()) % 1024, y: Int(rand()) % 768);
            
            swarmMemberArray.addObject(swarmMember);
            
            addChild(swarmMember);
        }
        
        swarmChemistryOperation = SwarmChemistryOperation(swarmMemberArray: swarmMemberArray);
        swarmChemistryOperation!.threadPriority = 0;
        queue.addOperation(swarmChemistryOperation);
        
    }
    

   
    override func update(currentTime: CFTimeInterval)
    {
        if let tmp = swarmChemistryOperation
        {
            if tmp.finished
            {
                var swarmChemistryOperation = SwarmChemistryOperation(swarmMemberArray: swarmMemberArray);
                swarmChemistryOperation.threadPriority = 0;
                queue.addOperation(swarmChemistryOperation);
            }
        }
    
    }
}
