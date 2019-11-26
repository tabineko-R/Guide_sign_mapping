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

class MultipleToiletViewController: UIViewController {

        //@IBOutlet var sceneView2: ARSCNView!
    //新規VCをつけるときは適宜変える。
    //weakが必要？？
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
        buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "MultipleToilet", recursively: false)
        
        switch number {
        case 1:
            buttonNode = buttonNode?.childNode(withName: "MT_1", recursively: false)
        case 2:
            buttonNode = buttonNode?.childNode(withName: "MT_2", recursively: false)
        case 3:
            buttonNode = buttonNode?.childNode(withName: "MT_3", recursively: false)
        default:
            break
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



extension MultipleToiletViewController: ARSCNViewDelegate {
    
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
