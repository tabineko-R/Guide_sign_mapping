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

class PictgramsViewController: UIViewController {
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    // ①引数宣言　前画面の値
    var pictgramText:String = ""
    
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
        
        switch pictgramText{
        case "駐車場":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Parking", recursively: false)
            let thumbnailNode = buttonNode.childNode(withName: "Toilet", recursively: true)?.childNode(withName: "T_[1-9]", recursively: false)?.childNode(withName: "image", recursively: false)
            thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  #imageLiteral(resourceName: "parking")
        case "トイレ":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Toilet", recursively: false)
        case "車いす対応トイレ":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "MultipurposeToilet", recursively: false)
            /*
        case "郵便局":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Toilet", recursively: false)
        case "ホテル":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Toilet", recursively: false)
        case "金融機関":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Toilet", recursively: false)
        case "警察署・交番":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Toilet", recursively: false)
        case "消防署":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Toilet", recursively: false)
        case "学校":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Toilet", recursively: false)
        case "駅・電停":
            buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Toilet", recursively: false)
        */
        default:
            break
        }
        
    }
    
    //画面遷移の関数
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: sceneView),
            let result = sceneView.hitTest(location, options: nil).first else {
                return
        }
        
        let node = result.node //switch文用
        
        // ①storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        // ②遷移先ViewControllerのインスタンス取得(identifierの名前を間違うとフリーズ起こす)
        let toDetails = storyboard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        
        toDetails.pictgramText = pictgramText
        self.present(toDetails, animated: true, completion: nil)
        
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




extension PictgramsViewController: ARSCNViewDelegate {
    
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




