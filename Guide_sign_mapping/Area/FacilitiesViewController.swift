import UIKit
import ARKit
import SafariServices

class FacilitiesViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    // ①引数宣言　前画面の値
    var facilitiesText:String = ""
    var landmarkText:String = ""
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
                                 ["北方歴史資料館","",""],
                                 ["函館高田屋嘉兵衛資料館","",""],
                                 ["北方民族資料館","","hoppou"],
                                 ["郷土資料館（旧金森洋物店）","",""],
                                 ["函館市文学館","",""]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        //scn読み込み
        //areaTextで表示するscnを変更（エリア判定）
        switch areaText{
        case "Funami_park":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Funami_park.scn")!.rootNode
        case "Hakodate_mountain":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_mountain.scn")!.rootNode
        case "Hakodate_park":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_park.scn")!.rootNode
        case "Hakodate_station":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_Station.scn")!.rootNode
        case "Motomachi_park":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Motomachi_park.scn")!.rootNode
        case "Nearby_facilities":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Nearby_Facilities.scn")!.rootNode
        case "Red_brick_warehouse":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Red_brick_warehouse.scn")!.rootNode
        case "Roopway_station":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Roopway_station.scn")!.rootNode
        case "Tachimachi_misaki":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Tachimachi_misaki.scn")!.rootNode
        default:
            break
        }
        
        for i in 1 ..< Facilities.count{
            if facilitiesText == Facilities[i][0]{
                if i == 1{
                    buttonNode = buttonNode.childNode(withName: Facilities[1][2], recursively: false)
                    for j in 0 ..< Landmarks.count{
                        if landmarkText == Landmarks[j][0]{
                        buttonNode = buttonNode?.childNode(withName: Landmarks[j][0], recursively: false)
                        let thumbnailNode = buttonNode.childNode(withName: "image", recursively: false)
                        thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  UIImage(named: Landmarks[j][2])
                            }
                    }
                }else{
                    buttonNode = buttonNode.childNode(withName: Facilities[i][2], recursively: false)
                    for j in 0 ..< 20{
                        print(j)
                        let thumbnailNode = buttonNode.childNode(withName: "pins", recursively: false)?.childNode(withName: "pin0\(j)", recursively: false)
                        thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  UIImage(named: Facilities[i][2])
                    }
                    
                }
            }
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
        if facilitiesText == "観光施設"{
            toDetails.landmarkText = landmarkText
        }
        
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
