//
//  GameScene.swift
//  Prank
//
//  Created by Milind Pathiyal on 7/18/16.
//  Copyright (c) 2016 Milind Pathiyal. All rights reserved.
//
import SpriteKit
import CoreMotion
import AudioToolbox
import AVFoundation
class GameScene: SKScene, SKPhysicsContactDelegate{
    
    
    //var Audio = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("yo", ofType:"mp3")!)
    
    //var AudioPlayer = AVAudioPlayer()
    
    //AudioPlayer = AVAudioPlayer(contentsOfURL: Audio, error: nil)
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    var endNode = SKSpriteNode()

    
    override func didMoveToView(view: SKView) {
        
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNodeWithName("player") as! SKSpriteNode
        
        endNode = self.childNodeWithName("endNode") as! SKSpriteNode
        
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()){
            (data, error) in
            
            self.physicsWorld.gravity = CGVectorMake(CGFloat((data?.acceleration.x)!) * 7, CGFloat((data?.acceleration.y)!) * 7)
            
        }
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        
        //GO BACK TO FIRST LEVEL
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 2 {
            
            //END SCENE
            print("You Lost")
            
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"level1") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart GameScene */
            skView.presentScene(scene)
            
        }
        
        
        
        //GO TO SECOND LEVEL
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 7 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 7 {
            
            //END SCENE
            print("You Won")
            
            let skView1 = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"level9") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart GameScene */
            skView1.presentScene(scene)
        }
        
        
        
        //GO TO THIRD LEVEL
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 9 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 9 {
            
            //END SCENE
            print("You Won")
            
            let skView1 = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"level4") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart GameScene */
            skView1.presentScene(scene)
            
        }
        
        
        
        
        
        
        
        
        
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 5 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 5 {
            
            //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            playSound("yo")
            
            
          
            let imageName = "7.jpg"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            
            let width = UIScreen.mainScreen().bounds.size.width
            let height = UIScreen.mainScreen().bounds.size.height
            
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)

            self.view!.addSubview(imageView)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);

            
        
        }

}

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    var audioPlayer: AVAudioPlayer?
    
    func playSound(str:String) {
        let url = NSBundle.mainBundle().URLForResource(str, withExtension: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            guard let audioPlayer = audioPlayer else { return }
            
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
}
