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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        print("エリア：\(areaText)")
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
        
        
        //facilitiesTextで施設の判定
        switch facilitiesText{
        case "すべて表示する":
            break
            
        case "観光施設":
            buttonNode = buttonNode.childNode(withName: "Landmark", recursively: false)
            
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
