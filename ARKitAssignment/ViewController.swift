//
//  ViewController.swift
//  ARKitAssignment
//
//  Created by EKbana on 27/09/2022.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    private var node: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        earthAdd()
        // Set the scene to the view
        addPinchGesture()
      
    }
    func earthAdd() {
        let scene = SCNScene()
       
        let earthScene = SCNScene(named: "art.scnassets/Earth.scn")
        
        guard let earthNode = earthScene?.rootNode.childNode(withName: "earth", recursively: false) else {
            fatalError("error")
        }
        earthNode.position = SCNVector3(0, 0, -0.2)
     let rotateAnimation = SCNAction.rotateBy(x: 0, y: -0.2, z: 0, duration: 5)
      earthNode.runAction(SCNAction.repeatForever(rotateAnimation))
        self.node = earthNode
        scene.rootNode.addChildNode(earthNode)
        sceneView.scene = scene
    }
    private func addPinchGesture() {
           let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        sceneView.isUserInteractionEnabled = true
           self.sceneView.addGestureRecognizer(pinchGesture)
        
       }
    
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
    
//           switch gesture.state {
//           // 1
//           case .began:
//               gesture.scale = CGFloat(node.scale.x)
//               break
//           // 2
//           case .changed:
//               var newScale: SCNVector3
//       // a
//               if gesture.scale < 0.5 {
//                   newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
//       // b
//               } else if gesture.scale > 10 {
//                   newScale = SCNVector3(10, 10, 10)
//       // c
//               } else {
//                   newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
//               }
//       // d
//               node.scale = newScale
//           default:
//               break
//           }
//          let scale  = CGFloat(node.scale.x + 1) * 2
//        node.scale = SCNVector3(scale, scale, scale)
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

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
