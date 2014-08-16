//
//  GameViewController.swift
//  SwarmChemistry
//
//  Created by Simon Gladman on 15/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController
{

    @IBOutlet weak var threadButtonBar: UISegmentedControl!

    var scene : GameScene?;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        /* Pick a size for the scene */
        scene = GameScene(fileNamed:"GameScene")
        // Configure the view.
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        scene!.swarmChemistryOperationCount = 1;
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene!.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }
    
    @IBAction func threadButtonBarChangeHandler(sender: AnyObject)
    {
        scene!.swarmChemistryOperationCount = Int(pow(2.0, Float(threadButtonBar.selectedSegmentIndex)));
    }

    override func shouldAutorotate() -> Bool
    {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
