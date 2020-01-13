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
    var sendText:String = ""
    
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
    
    let Facilities: [[String]] = [["エリア別表示","Area","Area"],
    ["観光施設","Tourist Facilities","Landmark"],
    ["観光案内所", "Toulist Information Center","TIC"],
    ["駐車場","Parking","Parking"],
    ["トイレ",  "Toilet","Toilet"],
    ["車いす対応トイレ", "Toilet(Whellchair Accessible)","WAToilet"],
    ["郵便局",  "Post Office","Post_Office"],
    ["ホテル",  "Hotel",  "Hotel"],
    ["金融機関", "Bank", "Bank"],
    ["警察署・交番", "Police Station/Box", "Police"],
    ["消防署","Firehouse","Firehouse"],
    ["学校", "School","School"],
    ["駅・電停",  "Railway Station/Streetcar Stop" ,"Station"]]
    
    
    private var buttonNode: SCNNode!
    private let feedback = UIImpactFeedbackGenerator()
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        print(pictgramText)
        for i in 1 ..< Facilities.count{
            if(pictgramText == Facilities[i][2]){
                navItem.title = Facilities[i][0]
            }
        }
        
        buttonNode = SCNScene(named: "art.scnassets/sign01/Guide_sign_mapping.scn")!.rootNode
        
        switch pictgramText{
        case "Parking":
            buttonNode = buttonNode.childNode(withName: "Parking", recursively: false)
            let thumbnailNode = buttonNode.childNode(withName: "pins", recursively: false)?.childNode(withName: "pin", recursively: false)
            thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  #imageLiteral(resourceName: "parking")
        case "Toilet":
            buttonNode = buttonNode.childNode(withName: "Toilet", recursively: false)
            let thumbnailNode = buttonNode.childNode(withName: "pins", recursively: false)?.childNode(withName: "pin", recursively: false)
            thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  #imageLiteral(resourceName: "parking")
        case "WAToilet":
            buttonNode = buttonNode.childNode(withName: "WAToilet", recursively: false)
            let thumbnailNode = buttonNode.childNode(withName: "pins", recursively: false)?.childNode(withName: "pin", recursively: false)
            thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  #imageLiteral(resourceName: "parking")
            /*
        case "郵便局":

        case "ホテル":
           
        case "金融機関":

        case "警察署・交番":

        case "消防署":
           
        case "学校":

        case "駅・電停":
          
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
        
        sendText = node.name!
        toDetails.landmarkText = sendText
        self.navigationController?.pushViewController(toDetails, animated: true)
        //self.present(toDetails, animated: true, completion: nil)
        
        print(node.name!)
        
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




