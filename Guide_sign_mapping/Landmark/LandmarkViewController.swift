import UIKit
import ARKit
import SafariServices

class LandmarkViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    
    // ①引数宣言　前画面の値
       var landmarkText:String = ""
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
    
    
    private var buttonNode: SCNNode!
    private let feedback = UIImpactFeedbackGenerator()
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    let Landmarks: [[String]] = [["遊覧船のりば","",""],
                                    ["函館明治館（旧函館郵便局）","","meiji"],
                                    ["中華会館","",""],
                                    ["金森美術館（バカラコレクション）","",""],
                                    ["旧北海道庁 函館支庁庁舎・旧開拓使書籍庫(観光案内所・写真歴史館)","",""],
                                    ["旧ロシア領事館","",""],
                                    ["旧イギリス領事館（開港記念館）","",""],
                                    ["太刀川家住宅（重要文化財）","",""],
                                    ["旧函館区公会堂（重要文化財）","",""],
                                    ["ハリストス正教会（重要文化財）","",""],
                                    ["東本願寺函館別院（重要文化財）","",""],
                                    ["日本基督教団函館教会","",""],
                                    ["カトリック元町教会","",""],
                                    ["聖ヨハネ教会","",""],
                                    ["新島襄海外渡航の地碑","",""],
                                    ["北海道第一歩の地碑","",""],
                                    ["ペリー提督来航記念碑","",""],
                                    ["北方歴史資料館","","hoppou"],
                                    ["函館高田屋嘉兵衛資料館","",""],
                                    ["北方民族資料館","",""],
                                    ["郷土資料館（旧金森洋物店）","",""],
                                    ["函館市文学館","",""]]
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        //scn読み込み
        //最初にscnの読み込みを指定（テスト）
        buttonNode = SCNScene(named: "art.scnassets/sign01/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "Landmark", recursively: false)
        
        navItem.title = landmarkText
        
        for i in 0 ..< Landmarks.count{
            if landmarkText == Landmarks[i][0]{
                    buttonNode = buttonNode?.childNode(withName: Landmarks[i][0], recursively: false)
                    let thumbnailNode = buttonNode.childNode(withName: "image", recursively: false)
                    thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  UIImage(named: Landmarks[i][2])
                }
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
        self.navigationController?.pushViewController(toDetails, animated: true)
        //self.present(toDetails, animated: true, completion: nil)

    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(imageConfiguration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @IBAction func toDetail(_ sender: Any) {

        let storyboard: UIStoryboard = self.storyboard!
        let toDetails = storyboard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        toDetails.landmarkText = landmarkText
        self.navigationController?.pushViewController(toDetails, animated: true)

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



