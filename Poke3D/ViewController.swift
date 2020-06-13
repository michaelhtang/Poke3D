//
//  ViewController.swift
//  Poke3D
//
//  Created by Michael Tang on 2020-06-12.
//  Copyright © 2020 Michael Tang. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 9
            
            print("Images Succesfully Added")
        }
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
            
            switch imageAnchor.referenceImage.name {
            case "squirtleBase":
                spawnPokemon(named: "squirtleBase" ,on: planeNode, euler: -.pi)
            case "wartortle":
                spawnPokemon(named: "wartortle" ,on: planeNode, euler: -.pi / 2)
            case "blastoise":
                spawnPokemon(named: "blastoise" ,on: planeNode, euler: -.pi)
            case "charmander":
                spawnPokemon(named: "charmander" ,on: planeNode, euler: -.pi)
            case "charmeleon":
                spawnPokemon(named: "charmeleon" ,on: planeNode, euler: -.pi / 2)
            case "charizard":
                spawnPokemon(named: "charizard" ,on: planeNode, euler: -.pi)
            case "bulbasaur":
                spawnPokemon(named: "bulbasaur" ,on: planeNode, euler: -.pi)
            case "ivysaur":
                spawnPokemon(named: "ivysaur" ,on: planeNode, euler: -.pi / 2)
            case "venusaur":
                spawnPokemon(named: "venusaur" ,on: planeNode, euler: -.pi)
            default:
                return node
            }
        }
        
        return node
    }
 
    func spawnPokemon(named name: String, on planeNode: SCNNode, euler: Float) {
        if let pokeScene = SCNScene(named: "art.scnassets/\(name).scn") {
            
            if let pokeNode = pokeScene.rootNode.childNodes.first {
                pokeNode.eulerAngles.x = euler
                planeNode.addChildNode(pokeNode)
                
                
            }
        }
    }
    
}
