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
            
            // swarm chemistry...
            
            var neighbours : NSMutableArray = NSMutableArray();
            var localCentreX : Double = 0;
            var localCentreY : Double = 0;
            var localDx : Double = 0;
            var localDy : Double = 0;
            
            var tempAx : Double = 0;
            var tempAy : Double = 0;
            
            for tmp in swarmMemberArray
            {
                let candidateNeighbour = tmp as SwarmMember;
                
                let distance = Double(sqrt(((swarmMember.position.x - candidateNeighbour.position.x) * (swarmMember.position.x - candidateNeighbour.position.x)) + ((swarmMember.position.y - candidateNeighbour.position.y) * (swarmMember.position.y - candidateNeighbour.position.y))));
                
                
                if distance < swarmMember.genome!.radius
                {
                    candidateNeighbour.distance = distance; //max,(distance, 0.001);
               
                    if candidateNeighbour.distance < 0.0001
                    {
                        candidateNeighbour.distance = 0.0001;
                    }
                    
                    neighbours.addObject(candidateNeighbour);
                    
                    localCentreX += Double(candidateNeighbour.position.x);
                    localCentreY += Double(candidateNeighbour.position.y);
                    localDx += candidateNeighbour.dx;
                    localDy += candidateNeighbour.dy;
                }
    
            }
            
            localCentreX = localCentreX / Double(neighbours.count);
            localCentreY = localCentreY / Double(neighbours.count);
            localDx = localDx / Double(neighbours.count);
            localDy = localDy / Double(neighbours.count);
            
            
            // do swarm chemisty....
            
            tempAx = tempAx + (localCentreX - Double(swarmMember.position.x)) * swarmMember.genome!.c1_cohesion;
            tempAy = tempAy + (localCentreY - Double(swarmMember.position.y)) * swarmMember.genome!.c1_cohesion;
            
            tempAx = tempAx + (localDx - swarmMember.dx) * swarmMember.genome!.c2_alignment;
            tempAy = tempAy + (localDy - swarmMember.dy) * swarmMember.genome!.c2_alignment;
            
            
            for tmp in neighbours
            {
                let neighbour = tmp as SwarmMember;
                
                tempAx = tempAx + Double(swarmMember.position.x - neighbour.position.x) / neighbour.distance * swarmMember.genome!.c3_seperation;
                tempAy = tempAy + Double(swarmMember.position.y - neighbour.position.y) / neighbour.distance * swarmMember.genome!.c3_seperation;
            }
            
            
            if Double(rand() % 100) < (swarmMember.genome!.c4_steering * 100.0)
            {
                tempAx = tempAx + Double(rand() % 4) - 2.0;
                tempAy = tempAy + Double(rand() % 4) - 2.0;
            }

            
            
            swarmMember.accelerate(tempAx, ay: tempAy, maxMove: swarmMember.genome!.maximumSpeed);
            
            var distance = sqrt(swarmMember.dx2 * swarmMember.dx2 +  swarmMember.dy2 *  swarmMember.dy2);
            
            if distance < 0.001
            {
                distance = 0.001;
            }
            
            
            swarmMember.accelerate(swarmMember.dx2 * (swarmMember.genome!.normalSpeed - distance) / distance * swarmMember.genome!.c5_paceKeeping,
                ay: swarmMember.dy2 * (swarmMember.genome!.normalSpeed - distance) / distance * swarmMember.genome!.c5_paceKeeping,
                maxMove: swarmMember.genome!.maximumSpeed);
            
            swarmMember.move();
            
        }
        
        /*
        for swarmMember in sswarmMemberArray
        {
            swarmMember.move();
        }
        */
        
    }
}
