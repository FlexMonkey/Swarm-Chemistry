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
    var swarmChemistryOperations : Array<SwarmChemistryOperation>?;
    var swarmChemistryOperationCount = 1;
    
    var swarmMemberArray : NSMutableArray = NSMutableArray(capacity: 4096);
    let swarmMemberRange : Range<Int> = 0..<4096;
    
    let queue = NSOperationQueue();
    
    var startTime : CFAbsoluteTime?;
    
    override func didMoveToView(view: SKView)
    {
        backgroundColor = UIColor.blackColor();
        
        for i in swarmMemberRange
        {
            let swarmMember : SwarmMember = SwarmMember(color: UIColor.redColor(), size: CGSize(width: 2, height: 2));
            
            swarmMember.position = CGPoint(x: Int(rand()) % 1024, y: Int(rand()) % 768);
            
            swarmMemberArray.addObject(swarmMember);
            
            addChild(swarmMember);
        }
        
        dispatchSwarmChemistryOperations();
        
    }
    
    private func dispatchSwarmChemistryOperations()
    {
        startTime = CFAbsoluteTimeGetCurrent();
        
        swarmChemistryOperations = Array<SwarmChemistryOperation>();
        
        let sampleSize : Int = 4096 / swarmChemistryOperationCount;
        
        for var i = 0; i < swarmChemistryOperationCount; i++
        {
            var swarmChemistryOperation = SwarmChemistryOperation(swarmMemberArray: swarmMemberArray, startIndex: i * sampleSize, sampleSize: sampleSize);
            swarmChemistryOperation.threadPriority = 0;
            
            swarmChemistryOperations?.append(swarmChemistryOperation)
            queue.addOperation(swarmChemistryOperation)
        }
    }
    
   
    override func update(currentTime: CFTimeInterval)
    {
        var operationsStillRunning : Bool = false;
        
        for swarmChemistryOperation in swarmChemistryOperations!
        {
            if !swarmChemistryOperation.finished
            {
                operationsStillRunning = false;
            }
        }
  
        if !operationsStillRunning
        {
            println("\(swarmChemistryOperations!.count) Operations time:" + NSString(format: "%.4f", CFAbsoluteTimeGetCurrent() - startTime!));
            
            dispatchSwarmChemistryOperations();
        }
    }
}
