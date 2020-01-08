import UIKit
import ARKit

class FirstScreenViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    private var buttonNode2: SCNNode!
    private let feedback = UIImpactFeedbackGenerator()
    
    let Landmarks:[[String]] = [
        ["船見公園","Funami_park"],
        ["函館山","Hakodate_mountain"],
        ["函館公園","Hakodate_park"],
        ["函館駅","Hakodate_station"],
        ["元町公園","Motomachi_park"],
        ["周辺施設","Nearby_facilities"],
        ["赤レンガ倉庫","Red_brick_warehouse"],
        ["ロープウェイ山麓駅","Roopway_station"],
        ["立町岬","Tachimachi_misaki"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        //scn読み込み
        buttonNode = SCNScene(named: "art.scnassets/sign01/Areas.scn")!.rootNode.childNode(withName: "Name", recursively: false)
        
        
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
        let toFacilities = storyboard.instantiateViewController(withIdentifier: "facilities") as! SelectFacilitiesViewController
        let toAreas = storyboard.instantiateViewController(withIdentifier: "areas") as! SelectFacilitiesInAreaViewController
        

        
        switch node.name {
        case "Facilities":
            //通常の画面遷移 //self.present(toLandmarks, animated: true, completion: nil)
            //Navigation Barを維持しての画面遷移
            self.navigationController?.pushViewController(toFacilities, animated: true)
        case "\(Landmarks[0][1])":
            toAreas.areaText = Landmarks[0][1]
            toAreas.areaText_ja = Landmarks[0][0]
            self.navigationController?.pushViewController(toAreas, animated: true)
        case "\(Landmarks[1][1])":
            toAreas.areaText = Landmarks[1][1]
            toAreas.areaText_ja = Landmarks[1][0]
            self.navigationController?.pushViewController(toAreas, animated: true)
        case "\(Landmarks[2][1])":
            toAreas.areaText = Landmarks[2][1]
            toAreas.areaText_ja = Landmarks[2][0]
            self.navigationController?.pushViewController(toAreas, animated: true)
        case "\(Landmarks[3][1])":
            toAreas.areaText = Landmarks[3][1]
            toAreas.areaText_ja = Landmarks[3][0]
            self.navigationController?.pushViewController(toAreas, animated: true)
        case "\(Landmarks[4][1])":
            toAreas.areaText = Landmarks[4][1]
            toAreas.areaText_ja = Landmarks[4][0]
            self.navigationController?.pushViewController(toAreas, animated: true)
        case "\(Landmarks[5][1])":
            toAreas.areaText = Landmarks[5][1]
            toAreas.areaText_ja = Landmarks[5][0]
            self.navigationController?.pushViewController(toAreas, animated: true)
        case "\(Landmarks[6][1])":
            toAreas.areaText = Landmarks[6][1]
            toAreas.areaText_ja = Landmarks[6][0]
            self.navigationController?.pushViewController(toAreas, animated: true)
        case "\(Landmarks[7][1])":
            toAreas.areaText = Landmarks[7][1]
            toAreas.areaText_ja = Landmarks[7][0]
            self.navigationController?.pushViewController(toAreas, animated: true)
        case "\(Landmarks[8][1])":
            toAreas.areaText = Landmarks[8][1]
            toAreas.areaText_ja = Landmarks[8][0]
            self.navigationController?.pushViewController(toAreas, animated: true)
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



extension FirstScreenViewController: ARSCNViewDelegate {
    
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
