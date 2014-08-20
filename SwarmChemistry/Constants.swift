//
//  Constants.swift
//  SwarmChemistry
//
//  Created by Simon Gladman on 17/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation
import UIKit;

public struct Constants
{
    static let genomeOne = SwarmGenome(color: UIColor.redColor(), radius: 25, c1_cohesion: 1, c2_alignment: 1, c3_seperation: 100, c4_steering: 0.5, c5_paceKeeping: 1);
    static let genomeTwo = SwarmGenome(color: UIColor.blueColor(), radius: 25, c1_cohesion: 1, c2_alignment: 1, c3_seperation: 100, c4_steering: 0.5, c5_paceKeeping: 1);
    static let genomeThree = SwarmGenome(color: UIColor.greenColor(), radius: 25, c1_cohesion: 1, c2_alignment: 1, c3_seperation: 100, c4_steering: 0.5, c5_paceKeeping: 1);
    static let genomeFour = SwarmGenome(color: UIColor.whiteColor(), radius: 25, c1_cohesion: 1, c2_alignment: 1, c3_seperation: 100, c4_steering: 0.5, c5_paceKeeping: 1);
    
    static let WIDTH : CGFloat = 1024;
    static let HEIGHT : CGFloat = 768; 
}