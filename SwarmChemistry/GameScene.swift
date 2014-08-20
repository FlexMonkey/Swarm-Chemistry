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
    let genomes : Array<SwarmGenome> = [Constants.genomeOne, Constants.genomeTwo, Constants.genomeThree, Constants.genomeFour];
    
    var swarmChemistryOperations : Array<SwarmChemistryOperation>?;
    var swarmChemistryOperationCount = 1;
    
    var swarmMemberArray : NSMutableArray = NSMutableArray(capacity: 128); //
    let swarmMemberRange : Range<Int> = 0..<128;
    
    let queue = NSOperationQueue();
    
    var startTime : CFAbsoluteTime?;
    
    override func didMoveToView(view: SKView)
    {
        backgroundColor = UIColor.blackColor();
        
       
        for i in swarmMemberRange
        {
            let genome : SwarmGenome = genomes[i % 4];
            let swarmMember : SwarmMember = SwarmMember(genome: genome);
            
            swarmMember.position = CGPoint(x: Int(rand()) % Int(Constants.WIDTH), y: Int(rand()) % Int(Constants.HEIGHT));
            
            swarmMemberArray.addObject(swarmMember);
            
            addChild(swarmMember);
        }
        
        dispatchSwarmChemistryOperations();
    }
    
    private func dispatchSwarmChemistryOperations()
    {
        startTime = CFAbsoluteTimeGetCurrent();
        
        swarmChemistryOperations = Array<SwarmChemistryOperation>();
        
        let sampleSize : Int = swarmMemberArray.count / swarmChemistryOperationCount;
        
        queue.maxConcurrentOperationCount = swarmChemistryOperationCount;
        
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
