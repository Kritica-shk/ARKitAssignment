//
//  ViewController.swift
//  ARKit2
//
//  Created by EKbana on 29/09/2022.
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
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        addBox()
        addPinchGesture()
        // Set the scene to the view
//        sceneView.scene = scene
    }
    func addBox(x: Float = 0, y: Float = -0.1, z: Float = -0.2) {
            // 1
            let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
     
            // 2
            let colors = [UIColor.green, // front
                UIColor.red, // right
                UIColor.blue, // back
                UIColor.yellow, // left
                UIColor.purple, // top
                UIColor.gray] // bottom
            let sideMaterials = colors.map { color -> SCNMaterial in
                let material = SCNMaterial()
                material.diffuse.contents = color
                material.locksAmbientWithDiffuse = true
                return material
            }
            box.materials = sideMaterials
     
            // 3
            self.node = SCNNode()
            self.node.geometry = box
            self.node.position = SCNVector3(x, y, z)
     
            //4
            sceneView.scene.rootNode.addChildNode(self.node)
        }
    
    private func addPinchGesture() {
           let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        sceneView.isUserInteractionEnabled = true
           self.sceneView.addGestureRecognizer(pinchGesture)
        
       }
    
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
    
           switch gesture.state {
           // 1
           case .began:
               gesture.scale = CGFloat(node.scale.x)
           // 2
           case .changed:
               var newScale: SCNVector3
       // a
               if gesture.scale < 0.5 {
                   newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
       // b
               } else if gesture.scale > 3 {
                   newScale = SCNVector3(3, 3, 3)
       // c
               } else {
                   newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
               }
       // d
               node.scale = newScale
           default:
               break
           }
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
