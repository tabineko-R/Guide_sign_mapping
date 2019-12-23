import UIKit
import ARKit
import SafariServices

class FacilitiesViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    // ①引数宣言　前画面の値
    var facilitiesText:String = ""
    var areaText:String = ""
    
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
        //areaTextで表示するscnを変更（エリア判定）
        switch areaText{
        case "船見公園周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_park.scn")!.rootNode
        case "函館山周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_park.scn")!.rootNode
        case "函館公園周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_park.scn")!.rootNode
        case "函館駅周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_Station.scn")!.rootNode
        case "元町公園周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Motomachi_park.scn")!.rootNode
        case "周辺施設":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Nearby_Facilities.scn")!.rootNode
        case "赤レンガ倉庫周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Red_brick_warehouse.scn")!.rootNode
        case "ロープウェイ山麓駅周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Roopway_station.scn")!.rootNode
        case "立待岬":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Roopway_station.scn")!.rootNode
        default:
            break
        }
        
        
        //facilitiesTextで施設の判定
        switch facilitiesText{
        case "すべて表示する":
            break
        case "観光施設":
            break
        case "駐車場":
            buttonNode = buttonNode.childNode(withName: "Parking", recursively: false)
            let thumbnailNode = buttonNode.childNode(withName: "pins", recursively: false)?.childNode(withName: "pin", recursively: false)
            thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  #imageLiteral(resourceName: "parking")
        case "トイレ":
            buttonNode = buttonNode.childNode(withName: "Toilet", recursively: false)
            let thumbnailNode = buttonNode.childNode(withName: "pins", recursively: false)?.childNode(withName: "pin", recursively: false)
            thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  #imageLiteral(resourceName: "parking")
        case "車いす対応トイレ":
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
        
        //施設の数をカウントする. これ実装できたのすごく嬉しい
        //let facilities_num:Int = buttonNode.childNode(withName: "pins", recursively: false)?.childNodes.count ?? 0
        //print(facilities_num)

    }
    
    //画面遷移の関数
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: sceneView),
            let result = sceneView.hitTest(location, options: nil).first else {
                return
        }
        
        //let node = result.node //switch文用
        
        // ①storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        // ②遷移先ViewControllerのインスタンス取得(identifierの名前を間違うとフリーズ起こす)
        let toDetails = storyboard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        
        toDetails.landmarkText = facilitiesText
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




extension FacilitiesViewController: ARSCNViewDelegate {
    
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
