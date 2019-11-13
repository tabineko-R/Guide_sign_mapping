import UIKit
import ARKit
import SafariServices

class ToiletViewController: UIViewController {
    //@IBOutlet var sceneView2: ARSCNView!
    //新規VCをつけるときは適宜変える。
    //weakが必要？？
    @IBOutlet weak var sceneView2: ARSCNView!
    
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
        sceneView2.delegate = self
        
        //scn読み込み
        //最初にscnの読み込みを指定（テスト）
        buttonNode = SCNScene(named: "art.scnassets/Guide_sign_mapping.scn")!.rootNode
        
        switch number {
        case 1:
            buttonNode = buttonNode.childNode(withName: "Toilet/1", recursively: false)
        case 2:
            buttonNode = buttonNode.childNode(withName: "Toilet/2", recursively: false)
        case 3:
            buttonNode = buttonNode.childNode(withName: "Toilet/3", recursively: false)
        default:
            break
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView2.session.run(imageConfiguration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView2.session.pause()
    }
    
}


extension ToiletViewController: ARSCNViewDelegate {
    
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



