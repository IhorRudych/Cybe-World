//
//  ARViewController.swift
//  Cybe World
//
//  Created by Ihor Rudych on 3/5/18.
//  Copyright © 2018 Ihor Rudych. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let myTouch = touches.first else {return}
        
        let touchResult = sceneView.hitTest(myTouch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = touchResult.last else {return}
        let hitTransf = SCNMatrix4(hitResult.worldTransform)
        let hitVector = SCNVector3(hitTransf.m41, hitTransf.m42, hitTransf.m43)
        self.createBall(position: hitVector)
    }
    
    func createBall(position:SCNVector3){
        let ballShp = SCNSphere(radius: 0.1)
        let ballNd = SCNNode(geometry: ballShp)
        ballNd.position = position
        sceneView.scene.rootNode.addChildNode(ballNd)
        
    }
}
