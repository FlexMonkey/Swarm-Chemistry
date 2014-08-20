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
                    candidateNeighbour.distance = distance; //max(distance, 0.001);
                    
                    neighbours.addObject(candidateNeighbour);
                    
                    localCentreX += Double(candidateNeighbour.position.x);
                    localCentreY += Double(candidateNeighbour.position.y);
                    localDx += candidateNeighbour.dx;
                    localDy += candidateNeighbour.dy;
                }
    
            }
            
            
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
            
            /*
            if (Math.random() < swarmMember.genome.c4_steering)
            {
                tempAx += Math.random() * 4 - 2;
                tempAy += Math.random() * 4 - 2;
            }
*/
            
            /*
            swarmMember.accelerate(tempAx, tempAy, swarmMember.genome.maximumSpeed);
            
            distance = sqrt(swarmMember.dx2 * swarmMember.dx2 +  swarmMember.dy2 *  swarmMember.dy2);
            
            if (distance == 0)
            {
                distance = 0.001;
            }
            swarmMember.accelerate(swarmMember.dx2 * (swarmMember.genome.normalSpeed - distance) / distance * swarmMember.genome.c5_paceKeeping,
                swarmMember.dy2 * (swarmMember.genome.normalSpeed - distance) / distance * swarmMember.genome.c5_paceKeeping,
                swarmMember.genome.maximumSpeed);
            */
        }
        
        /*
        for swarmMember in sswarmMemberArray
        {
            swarmMember.move();
        }
        */
        
    }
}
