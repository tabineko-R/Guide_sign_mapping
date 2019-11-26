//
//  MultipleToiletViewController.swift
//  Guide_sign_mapping
//
//  Created by yuya on 2019/11/25.
//  Copyright © 2019 yuya. All rights reserved.
//

import UIKit
import ARKit
import SafariServices

class LandmarkViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    
    // ①引数宣言
       var number = 0
    
    // NOTE: The imageConfiguration is better for tracking images,
    // but it has less features,
    // for example it does not have the plane detection.
    let defaultConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        
        let images = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
        configuration.detectionImages = images
        configuration.maximumNumberOfTrackedImages = 1
        return configuration
    }()
    
    let imageConfiguration: ARImageTrackingConfiguration = {
        let configuration = ARImageTrackingConfiguration()
        
        let images = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
        configuration.trackingImages = images!
        configuration.maximumNumberOfTrackedImages = 1
        return configuration
    }()
    
    
    private var buttonNode: SCNNode!
    private let feedback = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        //scn読み込み
        //最初にscnの読み込みを指定（テスト）
        buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Landmark", recursively: false)
        
        switch number {
        case 1:
            buttonNode = buttonNode?.childNode(withName: "L_1", recursively: false)
        case 2:
            buttonNode = buttonNode?.childNode(withName: "L_2", recursively: false)
        case 3:
            buttonNode = buttonNode?.childNode(withName: "L_3", recursively: false)
        default:
            break
            }
    }
    
    //オブジェクトにURL挿入
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: sceneView),
            let result = sceneView.hitTest(location, options: nil).first else {
                return
        }
        let node = result.node
        
        switch node.name {
        case "1":
            let safariVC = SFSafariViewController(url: URL(string: "https://ja.wikipedia.org/wiki/10%E6%9C%881%E6%97%A5")!)
            self.present(safariVC, animated: true, completion: nil)
        
        default: break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(imageConfiguration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
}




extension LandmarkViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return nil
        }
        
        //画像が認識された時に表示するscnのswitch文
        switch imageAnchor.referenceImage.name {
        case "information_sign" :
            DispatchQueue.main.async {
                self.feedback.impactOccurred()
            }
            return buttonNode
            
        default:
            return nil
        }
    }
}



