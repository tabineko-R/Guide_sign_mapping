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
    
    // ①引数宣言　前画面の値
       var landmarkText:String = ""
    
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
        
        switch landmarkText{
        case "旧ロシア領事館":
        buttonNode = buttonNode?.childNode(withName: "旧ロシア領事館", recursively: false)
        let thumbnailNode = buttonNode.childNode(withName: "pins", recursively: false)?.childNode(withName: "pin", recursively: false)
        thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  #imageLiteral(resourceName: "parking")
        case "太刀川家住宅（重要文化財）":
        buttonNode = buttonNode?.childNode(withName: "太刀川家住宅（重要文化財）", recursively: false)
        case "中華会館":
        buttonNode = buttonNode?.childNode(withName: "中華会館", recursively: false)
        case "新島襄海外渡航の地碑":
        buttonNode = buttonNode?.childNode(withName: "新島襄海外渡航の地碑", recursively: false)
        case "旧函館区公会堂（重要文化財）":
        buttonNode = buttonNode?.childNode(withName: "旧函館区公会堂（重要文化財）", recursively: false)
        case "旧北海道庁 函館支庁庁舎・旧開拓使書籍庫(観光案内所・写真歴史館)":
        buttonNode = buttonNode?.childNode(withName: "旧北海道庁 函館支庁庁舎・旧開拓使書籍庫(観光案内所・写真歴史館)", recursively: false)
        case "旧イギリス領事館（開港記念館）":
        buttonNode = buttonNode?.childNode(withName: "旧イギリス領事館（開港記念館）", recursively: false)
        case "ペリー提督来航記念碑":
        buttonNode = buttonNode?.childNode(withName: "ペリー提督来航記念碑", recursively: false)
        case "北方民族資料館":
        buttonNode = buttonNode?.childNode(withName: "北方民族資料館", recursively: false)
        case "日本基督教団函館教会":
        buttonNode = buttonNode?.childNode(withName: "日本基督教団函館教会", recursively: false)
        case "郷土資料館（旧金森洋物店）":
        buttonNode = buttonNode?.childNode(withName: "郷土資料館（旧金森洋物店）", recursively: false)
        case "函館市文学館":
            buttonNode = buttonNode?.childNode(withName: "函館市文学館", recursively: false)
        case "金森美術館（バカラコレクション）":
        buttonNode = buttonNode?.childNode(withName: "金森美術館（バカラコレクション）", recursively: false)
        case "北海道第一歩の地碑":
        buttonNode = buttonNode?.childNode(withName: "北海道第一歩の地碑", recursively: false)
        case "遊覧船のりば":
        buttonNode = buttonNode?.childNode(withName: "遊覧船のりば", recursively: false)
        case "北方歴史資料館":
        buttonNode = buttonNode?.childNode(withName: "北方歴史資料館", recursively: false)
        case "函館高田屋嘉兵衛資料館":
        buttonNode = buttonNode?.childNode(withName: "函館高田屋嘉兵衛資料館", recursively: false)
        case "函館明治館（旧函館郵便局）":
        buttonNode = buttonNode?.childNode(withName: "函館明治館（旧函館郵便局）", recursively: false)
        case "カトリック元町教会":
        buttonNode = buttonNode?.childNode(withName: "カトリック元町教会", recursively: false)
        case "ハリストス正教会（重要文化財）":
        buttonNode = buttonNode?.childNode(withName: "ハリストス正教会（重要文化財）", recursively: false)
        case "聖ヨハネ教会":
        buttonNode = buttonNode?.childNode(withName: "聖ヨハネ教会", recursively: false)
        case "東本願寺函館別院（重要文化財）":
        buttonNode = buttonNode?.childNode(withName: "東本願寺函館別院（重要文化財）", recursively: false)
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
        
        toDetails.landmarkText = landmarkText
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



